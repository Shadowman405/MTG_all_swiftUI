//
//  HpCounterView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI

struct HpCounterView: View {
    @State private var rotation:CGFloat = 0.0
    @State private var playerOneHP = 20
    @State private var playerTwoHP = 20
    
    @State private var showView = false
    @State private var playerOneColor = "{W}" 
    @State private var playerTwoColor = "{G}"
    @State private var playerOneHpTextPosition = true
    @State private var playerTwoHpTextPosition = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .overlay(.black)
                .ignoresSafeArea()
            
            VStack {
                HPsubview(playerHP: $playerOneHP, playerColor: $playerOneColor, changeHpTextPosition: $playerOneHpTextPosition)
                
                
                ZStack {
                    Divider()
                        .overlay(.orange)
                    
                    Button {
                        touchFeedback()
                        showView.toggle()
                    } label: {
                        Image("{B}")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                    AnimatedCircleView()
                }
                
                
                HPsubview(playerHP: $playerTwoHP, playerColor: $playerTwoColor, changeHpTextPosition: $playerTwoHpTextPosition)
                    .ignoresSafeArea()
                
            }
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $showView, content: {
            ColorChooseView(showView: $showView, playerOneColor: $playerOneColor, playerTwoColor: $playerTwoColor, playerOneHP: $playerOneHP, playerTwoHP: $playerTwoHP)
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    playerOneHP = 20
                    playerTwoHP = 20
                } label: {
                    Text("Refresh HP")
                        .foregroundColor(.orange)
                }
            } 
    }
    }
    
    private func touchFeedback() {
        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
        impactMed.impactOccurred()
    }
}

#Preview {
    HpCounterView()
}
