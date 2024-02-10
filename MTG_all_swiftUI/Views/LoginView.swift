//
//  LoginView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 15.11.23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var logedIn = false
    @State var toRegister = false
    @State private var email = ""
    @State private var password = ""
    //@State private var isLogedIn = false
    
    var body: some View {
        if logedIn {
           // ContentView()
            ContentView(logedIn: $logedIn)
        } else {
            content
        }
    }
    
    var content: some View {
        NavigationView {
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
                        .keyboardType(.emailAddress)
                        .foregroundColor(.white)
                        
                        Divider()
                            .foregroundColor(.gray)
                        
                        
                        Text("Password")
                            .foregroundColor(.white)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                        
                        SecureField("", text: $password, prompt: Text("Password...")
                            .foregroundColor(.orange.opacity(0.4)))
                        .textFieldStyle(.plain)
                        .foregroundColor(.white)
                        
                        Divider()
                            .foregroundColor(.gray)
                        
                    }
                    .padding()
                    
                    VStack {
                        Button {
                            login()
                        } label: {
                            Text("Log-in")
                                .bold()
                                .frame(width: 300, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(LinearGradient(colors: [.brown, .orange], startPoint: .top, endPoint: .bottomTrailing))
                                )
                                .foregroundColor(.white)
                        }
                        
                        Button {
                            toRegister.toggle()
                        } label: {
                            Text("New user ?   Register here.")
                        }
                        .offset(y: 10)
                    }
                }
                .onAppear {
                    FirebaseManager.shared.auth.addStateDidChangeListener { auth, user in
                        if user != nil {
                            logedIn.toggle()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $toRegister, content: {
            RegisterView()
        })
    }
    
    func login() {
        FirebaseManager.shared.auth.signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error log")
            }else {
                logedIn = true
            }
        }
    }
}

#Preview {
    LoginView()
}
