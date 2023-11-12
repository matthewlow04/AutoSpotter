//
//  CarProfileView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-05.
//

import SwiftUI

struct CarProfileView: View {
    @EnvironmentObject var dataManager: DataManager
    @State var currentCar: Car
    @State var showingDelete = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack{
            Text(currentCar.name)
                .font(Font.system(size: 30))
                .foregroundColor(.gray)
                .fontWeight(.black)
            ZStack(alignment: .bottomTrailing) {
                Image("car")
                    .resizable()
                    .scaledToFit()
                
                favoriteIcon
                    .onTapGesture {
                        currentCar.isFavourite.toggle()
                        dataManager.updateCar(carModel: currentCar.name, isFav: currentCar.isFavourite)
                    }
            }
            ScrollView{
               
                
                VStack(alignment: .leading){
                    
                    locationView
                        .padding()
                    notesView
                        .padding()
                    RatingView(rating: currentCar.rating)
                        .padding()
                    dateView
                        .padding()
                    deleteView
                  
                    
          
                }
                .confirmationDialog("Are you sure you want to delete \(currentCar.name) from your garage", isPresented: $showingDelete) {
                    Button("Delete"){
                        dataManager.deleteCar(carModel: currentCar.name)
                        dismiss()
                    }
                }
               
            }
        }
        
    }
    
    @ViewBuilder var favoriteIcon: some View{
        Image(systemName: currentCar.isFavourite ? "heart.fill" : "heart")
            .foregroundColor(Color.white)
            .padding()
            .background(Color.red)
            .clipShape(Circle())
            .overlay{
                Circle()
                    .strokeBorder(Color.white, lineWidth: 2)
            }
            .offset(x: -10, y: -10)
    }
    
    var locationView: some View{
        VStack(alignment: .leading){
            Text("LOCATION")
                .font(.title2)
                .foregroundColor(.gray)
                .fontWeight(.black)
            
            Text(currentCar.location)
            

        }
    }
    
    var notesView: some View{
        VStack(alignment: .leading){
            Text("NOTES")
                .font(.title2)
                .foregroundColor(.gray)
                .fontWeight(.black)
            
            Text(currentCar.notes)
            

        }
    }
    
    var dateView: some View{
        Text("Date added: \(formattedDate(date: currentCar.date))")
            .italic()
            .foregroundStyle(Color.gray)
    }
    var deleteView: some View{
        HStack{
            Spacer()
            Button("Delete Car"){
                showingDelete = true
               
            }
            .padding(10)
            .foregroundColor(.white)
            .font(.callout)
            .background(Color.red)
            .clipShape(Capsule(style: .circular))
            Spacer()
        }
    }

    
}

struct RatingView: View{
    var rating: Int
    var total = 10
    var body: some View{
        VStack(alignment: .leading){
            Text("Rating")
                .font(.title2)
                .foregroundColor(.gray)
                .fontWeight(.black)
                .padding(.bottom)
            HStack{
                Spacer()
                VStack{
                    HStack{
                        ForEach(1...total, id: \.self) { index in
                            Image(systemName: (index <= rating) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    Text("\(rating)/10")
                        .padding(.vertical)
                }
                Spacer()
            }
           
           
        }
    }
}

