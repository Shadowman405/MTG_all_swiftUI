//
//  LoginView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 15.11.23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLogedIn = false
    
    var body: some View {
        if isLogedIn {
           // ContentView()
            ContentView()
        } else {
            content
        }
    }
    
    var content: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack{
                VStack {
                    Image("mtg_login_logo-removebg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .offset(y: -50)
                }
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    
                    TextField("", text: $email, prompt: Text("Email...")
                        .foregroundColor(.orange.opacity(0.4)))
                    .textFieldStyle(.plain)
                    .foregroundColor(.blue)
                    
                    Divider()
                        .foregroundColor(.gray)
                    
                    
                    Text("Password")
                        .foregroundColor(.white)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    
                    TextField("", text: $password, prompt: Text("Password...")
                        .foregroundColor(.orange.opacity(0.4)))
                    .textFieldStyle(.plain)
                    .foregroundColor(.blue)
                    
                    Divider()
                        .foregroundColor(.gray)
                    
                }
                .padding()
                
                VStack {
                    Button {
                        register()
                    } label: {
                        Text("Sign Up")
                            .bold()
                            .frame(width: 300, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(LinearGradient(colors: [.brown, .orange], startPoint: .top, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                    
                    Button {
                        login()
                    } label: {
                        Text("Already have an account? Login")
                    }
                    .offset(y: 10)
                }
            }
            .navigationTitle("Login")
            .onAppear {
                FirebaseManager.shared.auth.addStateDidChangeListener { auth, user in
                    if user != nil {
                        isLogedIn.toggle()
                    }
                }
            }
        }
    }
    
    func register() {
        FirebaseManager.shared.auth.createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error reg")
            }
        }
    }
    
    func login() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error log")
            }
        }
    }
}

#Preview {
    LoginView()
}
