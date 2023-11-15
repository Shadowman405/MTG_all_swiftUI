//
//  LoginView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 15.11.23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        ZStack {
            Color(.black)
            
            VStack{
                Image("mtg_login_logo-removebg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y: -150)
                
                Text("Email")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -100,y: -100)
            }
        }
    }
}

#Preview {
    LoginView()
}
