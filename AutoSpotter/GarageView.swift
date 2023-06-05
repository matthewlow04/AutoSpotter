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
                Text(car.name)
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
