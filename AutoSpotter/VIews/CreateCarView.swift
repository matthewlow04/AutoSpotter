//
//  CreateCarView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-01.
//

import SwiftUI

struct CreateCarView: View {
    @State var name: String
    @State var notes = ""
    @State var location = ""
    @State var rating = 0.0
    @State var showingAlert = false
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    HStack{
                        Text("Name: ")
                        TextField("Name", text: $name)
                            .foregroundColor(Color.red).opacity(1)
                    }
                }header: {
                    Text("NAME")
                }
                Section{
                    HStack{
                        Text("Location: ")
                        TextField("Location spotted", text: $location)
                            .foregroundColor(Color.red).opacity(1)
                    }
                }header: {
                    Text("NOTES")
                }
                Section{
                    HStack{
                        Text("Notes: ")
                        TextField("Add custom notes", text: $notes)
                            .foregroundColor(Color.red).opacity(1)
                    }
                }header: {
                    Text("NOTES")
                }
                
                Section{
                    VStack{
                        Slider(value: $rating, in: 0...10, step: 1)
                        Text("Rating: \(String(format: "%.0f", rating))/10")
                    }
                    
                }header:{
                    Text("MY RATING")
                }
                Section{
                    Button("Add Car") {
                        let date = Date.now
                        dataManager.addCar(carModel: name, carNotes: notes, carLocation: location, rating: Int(rating), date: date)
                        dataManager.cars.append(Car(name: name, notes: notes, location: location, rating: Int(rating), date: date, isFavourite: false))
                        showingAlert = true
                        dismiss()
                    }
                    .alert("Car saved", isPresented: $showingAlert){
                        Button("OK", role: .cancel) {}
                    }
                }
                
            }
            .navigationTitle("Add New Car").foregroundColor(Color.red)
            
        }   
    }
}

struct CreateCarView_Previews: PreviewProvider {
    static var previews: some View {
        CreateCarView(name: "Civic")
    }
}
