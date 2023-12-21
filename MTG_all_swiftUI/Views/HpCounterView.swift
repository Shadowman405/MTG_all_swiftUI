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
    
    var body: some View {
        ZStack {
            Rectangle()
                .overlay(.black)
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    HStack {
                        Button {
                            touchFeedback()
                            playerOneHP -= 1
                        } label: {
                            Text("-")
                                .font(.system(size: 70))
                                .foregroundColor(.orange)
                                .offset(x: -20, y: 30)
                        }
                        
                        
                        VStack {
                            Image(playerOneColor)
                                .resizable()
                                .frame(width: 150,height: 150)
                                .rotationEffect(Angle(degrees: 180))
                        }
                        .offset(y: 50)
                        
                        
                        Button {
                            touchFeedback()
                            playerOneHP += 1
                        } label: {
                            Text("+")
                                .font(.system(size: 70))
                                .foregroundColor(.orange)
                                .offset(x: 20, y: 30)
                        }
                    }
                    .offset(y: 70)
                }
                .ignoresSafeArea()
                
                ZStack {
                    Color(.black)
                    Button {
                    } label: {
                    }
                    
                    
                    HStack{
                        Text("\(playerOneHP)")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                            .offset(y: 60)
                    }
                    .ignoresSafeArea()
                    .rotationEffect(.degrees(180), anchor: .center)
                    
                    Divider()
                        .overlay(.orange)
                    
                    HStack {
                        Text("\(playerTwoHP)")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                            .offset(y: 60)
                    }
                    .ignoresSafeArea()
                    
                    ZStack {
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
                }
                
                ZStack {
                    Rectangle()
                        .overlay(.black)
                        .ignoresSafeArea()
                    
                    HStack {
                        Button {
                            touchFeedback()
                            playerTwoHP -= 1
                        } label: {
                            Text("-")
                                .font(.system(size: 70))
                                .foregroundColor(.orange)
                                .offset(x: -20, y: -30)
                        }
                        
                        
                        VStack {
                            Image(playerTwoColor)
                                .resizable()
                                .frame(width: 150,height: 150)
                        }
                        .offset(y: -30)
                        
                        
                        Button {
                            touchFeedback()
                            playerTwoHP += 1
                        } label: {
                            Text("+")
                                .font(.system(size: 70))
                                .foregroundColor(.orange)
                                .offset(x: 20, y: -30)
                        }
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .fullScreenCover(isPresented: $showView, content: {
            ColorChooseView(showView: $showView, playerOneColor: $playerOneColor, playerTwoColor: $playerTwoColor)
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
