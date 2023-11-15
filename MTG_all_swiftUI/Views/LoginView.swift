//
//  LoginView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 15.11.23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
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
                        
                    } label: {
                        Text("Already have an account? Login")
                    }
                    .offset(y: 10)
                }
            }
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginView()
}
