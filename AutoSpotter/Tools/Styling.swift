//
//  Styling.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-01.
//

import Foundation
import SwiftUI

struct HomeButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View{
        configuration.label
            .font(.title2)
            .padding()
            .foregroundColor(.white)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: configuration.isPressed ? [.red.opacity(0.4), .pink.opacity(0.4)] : [.red, .pink]), startPoint: .leading, endPoint: .trailing)
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 2)
                }
            )
            .cornerRadius(10)
    }
}

struct textButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View{
        configuration.label
            .bold()
            .foregroundColor(.white)
    }
}
