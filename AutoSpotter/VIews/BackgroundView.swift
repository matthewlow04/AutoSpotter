//
//  BackgroundView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-01.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack{
            Color.pink
            
            RoundedRectangle(cornerRadius: 40, style: .circular)
                .foregroundStyle(.linearGradient(colors: [.gray, .black], startPoint: .topTrailing, endPoint: .bottomLeading))
                .frame(width: 1000, height:600)
                .rotationEffect(.degrees(135))
        }
        .ignoresSafeArea()
    
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
