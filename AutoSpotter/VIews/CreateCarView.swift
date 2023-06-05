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
    @State var showingAlert = false
    @EnvironmentObject var dataManager: DataManager
    var body: some View {
        NavigationView{
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
                    Button("Add Car") {
                        dataManager.addCar(carModel: name, carNotes: notes, carLocation: location)
                        dataManager.cars.append(Car(name: name, notes: notes, location: location))
                        showingAlert = true
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
