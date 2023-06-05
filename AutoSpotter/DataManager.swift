//
//  DataManager.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-04.
//

import Foundation
import Firebase

class DataManager: ObservableObject{
    @Published var cars: [Car] = []
    init(){
        fetchCars()
    }
    
    func fetchCars(){
        cars.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Cars")
        ref.getDocuments { snapshot, error in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot{
                for document in snapshot.documents{
                    let data = document.data()
                    let notes = data["notes"] as? String ?? ""
                    let name = data["name"] as? String ?? ""

                    let car = Car(name: name, notes:notes)
                    
                    self.cars.append(car)
                }
            }
        }
    }
    
    func addCar(carModel: String, carNotes: String){
        let db = Firestore.firestore()
        let ref = db.collection("Cars").document(carModel)
        ref.setData(["name":carModel, "notes":carNotes]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
            
        }
    }
}
