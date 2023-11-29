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
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .overlay(.black)
                    .ignoresSafeArea()
                
                
                HStack {
                    Button {
                        print("Minus")
                    } label: {
                        Text("-")
                            .font(.system(size: 70))
                            .foregroundColor(.orange)
                            .offset(x: -20, y: 30)
                    }
                    
                    
                    VStack {
                        Image("{W}")
                            .offset(y: 10)
                        
                        Text("\(playerOneHP)")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                    }
                    .offset(y: 50)
                    
                    
                    
                    Button {
                        print("Plus")
                    } label: {
                        Text("+")
                            .font(.system(size: 70))
                            .foregroundColor(.orange)
                            .offset(x: 20, y: 30)
                    }
                }
                .ignoresSafeArea()
            }
            
            ZStack {
                Color(.black)
                Button {
                } label: {
                }
                
                Divider()
                    .overlay(.orange)
                
                ZStack {
                    Button {
                        print("HP")
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
                        print("Minus")
                    } label: {
                        Text("-")
                            .font(.system(size: 70))
                            .foregroundColor(.orange)
                            .offset(x: -20, y: -30)
                    }
                    
                    
                    VStack {
                        Text("\(playerTwoHP)")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                            .offset(y: -10)
                        
                        Image("{G}")
                            .offset(y: -30)
                    }
                    .offset(y: -30)
                    
                    
                    Button {
                        playerTwoHP - 1
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
}

#Preview {
    HpCounterView()
}
