//
//  GarageView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-04.
//

import SwiftUI

struct GarageView: View {
    @EnvironmentObject var dataManager: DataManager
    @State var isShowingFavourites = false
    var body: some View {
        VStack{
            NavigationStack{
                if(isShowingFavourites){
                    if(dataManager.cars.filter{$0.isFavourite}.isEmpty){
                        List{
                            Text("No Favourites")
                                .font(Font.headline)
                                .opacity(0.7)
                                .italic()
                                
                        }
                        .navigationTitle("Garage (Favourites)")
                        .toolbar{
                            ToolbarItem(placement: .primaryAction) {
                                Button("Toggle Favourites"){
                                    isShowingFavourites.toggle()
                                }
                            }
                        }
                        
                        
                       
                               
                    }else{
                        List(dataManager.cars.filter{$0.isFavourite}, id: \.self){ car in
                            NavigationLink(destination: CarProfileView(currentCar: car)){
                                HStack{
                                    VStack(alignment: .leading, spacing: 6){
                                        Text((car.name))
                                            .bold()
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing){
                                        Text("Spotted: ")
                                        Text("\(formattedDate(date: car.date))")
                                        
                                    }
                                    .foregroundStyle(Color.gray)
                                    .italic()
                                   
                                }
                            }
                        }
                        .navigationTitle("Garage (Favourites)")
                       
                        .toolbar{
                            ToolbarItem(placement: .primaryAction) {
                                Button("Toggle Favourites"){
                                    isShowingFavourites.toggle()
                                }
                            }
                        }
                    }
                   
                }else{
                    List(dataManager.cars, id: \.self){ car in
                        NavigationLink(destination: CarProfileView(currentCar: car)){
                            HStack{
                                VStack(alignment: .leading, spacing: 6){
                                    Text((car.name))
                                        .bold()
                                }
                                Spacer()
                                VStack(alignment: .trailing){
                                    Text("Spotted: ")
                                    Text("\(formattedDate(date: car.date))")
                                    
                                }
                                .foregroundStyle(Color.gray)
                                .italic()
                               
                            }
                        }
                    }
                    .navigationTitle("Garage")
                    .toolbar{
                        ToolbarItem(placement: .primaryAction) {
                            Button("Toggle Favourites"){
                                isShowingFavourites = true
                            }
                               
                        }
                    }
                
                }
               
               
            }
        }
        .onAppear{
            dataManager.fetchCars()
        }
        .onDisappear{
            dataManager.fetchCars()
        }
        
        
    }
}

struct GarageView_Previews: PreviewProvider {
    static var previews: some View {
        GarageView()
    }
}
