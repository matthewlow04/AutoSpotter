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
                    let location = data["location"] as? String ?? "Unknown location"
                    let rating = data["rating"] as? Int ?? 0
                    let date = data["date"] as? Timestamp ?? Timestamp(date: Date.now)
                    let fav = data["isFavourite"] as? Bool ?? false
                    
                    let car = Car(name: name, notes:notes, location:location, rating: rating, date: date.dateValue(), isFavourite: fav)
                    
                    self.cars.append(car)
                }
            }
            
            print("fetch")
        }
    }
    
    func addCar(carModel: String, carNotes: String, carLocation: String, rating: Int, date: Date){
        let db = Firestore.firestore()
        let ref = db.collection("Cars").document(carModel)
        ref.setData(["name":carModel, "notes":carNotes, "location":carLocation, "rating": rating, "date": Timestamp(date: date), "isFavourite": false]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
            
        }
    }
    
    func updateCar(carModel: String, isFav: Bool){
        let db = Firestore.firestore()
        let ref = db.collection("Cars").document(carModel)
        
        ref.updateData(["isFavourite" : isFav]){ error in
            if let error = error{
                print(error.localizedDescription)
            }
            
        }
      
    }
    
    func deleteCar(carModel: String){
        let db = Firestore.firestore()
        let ref = db.collection("Cars").document(carModel)
        
        ref.delete { error in
            if let error = error {
                print("Error deleting: \(error.localizedDescription)")
            }
        }
        fetchCars()
    }
}
