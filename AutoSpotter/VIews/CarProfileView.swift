//
//  CarProfileView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-05.
//

import SwiftUI

struct CarProfileView: View {
    @State var currentCar: Car
    var body: some View {
        ScrollView{
           
            
            VStack(alignment: .leading){
                ZStack(alignment: .bottomTrailing) {
                    Image("car")
                        .resizable()
                        .scaledToFit()
                    
                    favoriteIcon
                        .onTapGesture {
                            currentCar.isFavourite.toggle()
                        }
                }
                locationView
                    .padding()
                notesView
                    .padding()
      
            }
            Spacer(minLength: 200)
            
            favouriteButton
                .buttonStyle(HomeButtonStyle())
        }
        .navigationTitle(currentCar.name)
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
    
    var favouriteButton: some View {
        
        Button("Add Favourite"){
            
        }
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
}

struct CarProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CarProfileView(currentCar: mockCar().mockCar)
    }
}
