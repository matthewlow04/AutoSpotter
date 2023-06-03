//
//  AutoSpotterApp.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-01.
//

import SwiftUI
import Firebase
@main
struct AutoSpotterApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView()
            //HomeView()
        }
    }
}
