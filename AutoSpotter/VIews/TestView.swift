//
//  TestView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-03.
//

import SwiftUI

struct TestView: View {
    @AppStorage("uid") var userID: String = ""
    var body: some View {
        if userID == ""{
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
