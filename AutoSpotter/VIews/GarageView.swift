//
//  GarageView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-04.
//

import SwiftUI

struct GarageView: View {
    @EnvironmentObject var dataManager: DataManager
    var body: some View {
        NavigationView{
            List(dataManager.cars, id: \.self){ car in
                NavigationLink(destination: CarProfileView(currentCar: car)){
                    HStack{
                        VStack(alignment: .leading, spacing: 6){
                            Text((car.name))
                                .bold()
                        }
                        
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
        }
    }
}

struct GarageView_Previews: PreviewProvider {
    static var previews: some View {
        GarageView()
    }
}
