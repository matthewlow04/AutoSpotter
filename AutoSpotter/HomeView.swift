//
//  ContentView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-01.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
 
        NavigationView{
            ZStack{
                BackgroundView()
                VStack(spacing: 50) {
                    Text("AutoSpotter")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    playButton
                        .buttonStyle(HomeButtonStyle())
                    garageButton
                        .buttonStyle(HomeButtonStyle())
                    
                  
                }
                .padding()
            }
        

         
        }
       
     
       
       
        
        
    }
    
    var playButton: some View {
        
        NavigationLink(destination: AddCarView()) {
            HStack{
                Text("Spot A Car")
                Image(systemName: "play")
            }
        
        }
    }
    
    var garageButton: some View {
        
        NavigationLink(destination: Text("My Cars")) {
            HStack{
                Text("My Garage")
                Image(systemName: "play")
            }
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
