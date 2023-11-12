//
//  AddCarView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-01.
//

import CoreML
import Vision
import SwiftUI

struct AddCarImageView: View{
    let model: CarRecognition = {
    do {
        let config = MLModelConfiguration()
        return try CarRecognition(configuration: config)
    } catch {
        print(error)
        fatalError("Couldn't create CarRecognition")
    }
    }()
    
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var classificationLabel = ""
    @State private var topThreeProbabilities: [String] = []
    @State private var probabilityDict = [String: Double]()
    @State private var evaluateTapped = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
            NavigationStack{
                ZStack{
                    BackgroundView()
                    VStack {
                        if(evaluateTapped){
                            Text("Predictions")
                        }else{
                            Text("")
                        }
                        ForEach(topThreeProbabilities, id: \.self) { probability in
                            Button(action: {
                                if let colon = probability.firstIndex(of: ":") {
                                            classificationLabel = String(probability[..<colon])
                                        }
                            }, label: {
                                Text(probability)
                            })
                            .padding(.bottom, 5)
                                
                                
                        }
                        .foregroundColor(.white)

                     
                        
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 224, height: 224)
                        } else {
                            Text("No Image Selected")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(width: 224, height: 224)
                        }
                        
                        Text(classificationLabel    )
                            .fontWeight(.bold)
                            .font(.title2)
                            .foregroundColor(.white)
                        

                       
                        
                        HStack{
                            Button("Pick Image") {
                                isShowingImagePicker = true
                            }
                            .buttonStyle(HomeButtonStyle())
                            
                            Button("Evaluate"){
                                let resizedImage = selectedImage!.resize(size: CGSize(width: 224, height: 224))
                                let output = try? self.model.prediction(data: buffer(from: resizedImage)!)
                                
                                if let output = output{
                                    classificationLabel = output.classLabel
                                    probabilityDict = output.prob
                                    
                                    let sortedProbabilities = probabilityDict.sorted { $0.value > $1.value }

                                    topThreeProbabilities = sortedProbabilities.prefix(5).map { "\($0.key): \(String(format: "%.2f", $0.value*100))%" }
                                    
                                }
                                evaluateTapped = true
                                
                            }
                            .disabled(selectedImage == nil)
                            .opacity(selectedImage == nil ? 0.5: 1)
                            .buttonStyle(HomeButtonStyle())
                        }

                        Spacer()
                        NavigationLink{
                            CreateCarView(name: classificationLabel).environmentObject(DataManager())
                        }label: {
                            HStack{
                                Text("Add Car")
                                Image(systemName: "car.fill")
                            }
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                           
                           
                        }
                        .disabled(selectedImage == nil)
                        .opacity(selectedImage == nil ? 0.5: 1)
                        .onDisappear{
                            evaluateTapped = false
                        }
                     
                    }.sheet(isPresented: $isShowingImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
                            
                }
               
            
            }
       
        }

    }
    
    
    
    func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
    
    

}

struct AddCarView_Previews: PreviewProvider {
    static var previews: some View {
        AddCarImageView()
    }
}
