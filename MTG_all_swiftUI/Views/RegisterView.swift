//
//  RegisterView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 10.02.24.
//

import SwiftUI
import Firebase

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack {
                Text("Email")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                
                TextField("", text: $email, prompt: Text("Enter Email...")
                    .foregroundColor(.orange.opacity(0.4)))
                .textFieldStyle(.plain)
                .keyboardType(.emailAddress)
                .foregroundColor(.white)
                .padding()
                
                //
                
                Text("Password")
                    .foregroundColor(.white)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                
                SecureField("Password", text: $password,prompt: Text("Enter Password...")
                    .foregroundColor(.orange.opacity(0.4)))
                    .textFieldStyle(.plain)
                    .foregroundColor(.white)
                    .padding()
                
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
}


#Preview {
    RegisterView()
}
