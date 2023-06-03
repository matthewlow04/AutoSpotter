//
//  LoginView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-03.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack{
            BackgroundView()
            
            VStack(spacing: 20){
                Text("AutoSpotter")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty, placeholder: {
                        Text("Email:")
                            .foregroundColor(.white)
                         
                    })
                
                Rectangle()
                    .frame(width:300, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty, placeholder: {
                        Text("Password:")
                            .foregroundColor(.white)
                           
                        
                    })
                Rectangle()
                    .frame(width:300, height: 1)
                    .foregroundColor(.white)
                
                
                
                signUpButton
                    .buttonStyle(HomeButtonStyle())
                    .padding(.top)
                    .offset(y:100)
                loginButton
                    .buttonStyle(textButtonStyle())
                    .offset(y:110)
                    
                
                
            }.frame(width: 300)
        }
    }
    
    
    var signUpButton: some View{
        Button{
            //sign up
        } label:{
            Text("Sign Up")
        }
    }
    
    var loginButton: some View{
        Button{
            //login
        } label:{
            Text("Already have an account? Sign in")
        }
        
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
