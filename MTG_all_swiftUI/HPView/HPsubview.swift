//
//  HPsubview.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 18.02.24.
//

import SwiftUI

struct HPsubview: View {
    @Binding var playerHP: Int
    @Binding var playerColor: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .overlay(.black)
                .ignoresSafeArea()
            
            HStack {
                Button {
                    touchFeedback()
                    playerHP -= 1
                } label: {
                    Text("-")
                        .font(.system(size: 70))
                        .foregroundColor(.orange)
                        .offset(x: -20, y: 30)
                }
                
                
                VStack {
                    Image(playerColor)
                        .resizable()
                        .frame(width: 150,height: 150)
                        .rotationEffect(Angle(degrees: 180))
                }
                .offset(y: 50)
                
                
                Button {
                    touchFeedback()
                    playerHP += 1
                } label: {
                    Text("+")
                        .font(.system(size: 70))
                        .foregroundColor(.orange)
                        .offset(x: 20, y: 30)
                }
            }
            .offset(y: 70)
            
        }
    }
    
    private func touchFeedback() {
        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
        impactMed.impactOccurred()
    }
}
    
    

#Preview {
    HPsubview(playerHP: .constant(20), playerColor: .constant("{W}"))
}
