//
//  LoginView.swift
//  AutoSpotter
//
//  Created by Matthew Low on 2023-06-03.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    @State private var signUpAlert = false
    @State private var username = ""
    @AppStorage("uid") var userID: String = ""
    
    var body: some View {
        if userIsLoggedIn{
            HomeView(userId: userID)
        } else{
            loginView
        }
    }
    
    var loginView: some View{
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
                    
                
                
            }
            .alert("User with email address: \(username) created", isPresented: $signUpAlert, actions: {
                Button("OK", role: .cancel) {}
            })
            .frame(width: 300)
           
//            .onAppear{
//                Auth.auth().addStateDidChangeListener { auth, user in
//                    if user != nil{
//                        //userIsLoggedIn.toggle()
//                    }
//                }
//            }
    
        }
    }
    
    
    var signUpButton: some View{
        Button{
            register()
        } label:{
            Text("Sign Up")
        }
    }
    
    var loginButton: some View{
        Button{
            login()
        } label:{
            Text("Already have an account? Sign in")
        }
        
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
            if let result = result{
                signUpAlert = true
                username = result.user.email!
            }
           
            
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
            
            if let result = result {
                print(result.user.uid)
                withAnimation {
                    userID = result.user.uid
                }
                userIsLoggedIn = true
            }
            
           
            
        }
    }
}



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
