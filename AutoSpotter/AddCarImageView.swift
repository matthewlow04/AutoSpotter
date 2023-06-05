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
    
    var body: some View {
        
            NavigationView{
                ZStack{
                    BackgroundView()
                    VStack {
                        
                        Text(classificationLabel)
                            .fontWeight(.bold)
                            .font(.title2)
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
                        

                        Button("Pick Image") {
                            isShowingImagePicker = true
                        }
                        .buttonStyle(HomeButtonStyle())
                        if selectedImage != nil{
                            VStack(){
                                Button("Evaluate"){
                                    let resizedImage = selectedImage!.resize(size: CGSize(width: 224, height: 224))
                                    let output = try? self.model.prediction(data: buffer(from: resizedImage)!)
                                    
                                    if let output = output{
                                        classificationLabel = output.classLabel
                                    }
                                    
                                }
                                .buttonStyle(HomeButtonStyle())
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
                                .offset(y: 170)

                            }
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
