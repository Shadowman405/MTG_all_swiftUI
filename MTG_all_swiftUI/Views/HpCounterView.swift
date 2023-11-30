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
                        playerOneHP -= 1
                    } label: {
                        Text("-")
                            .font(.system(size: 70))
                            .foregroundColor(.orange)
                            .offset(x: -20, y: 30)
                    }
                    
                    
                    VStack {
                        Image("{W}")
                    }
                    .offset(y: 50)
                    
 
                    Button {
                        playerOneHP += 1
                    } label: {
                        Text("+")
                            .font(.system(size: 70))
                            .foregroundColor(.orange)
                            .offset(x: 20, y: 30)
                    }
                }
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
                        .offset(y: -60)
                }
                .ignoresSafeArea()
                
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
                        playerTwoHP -= 1
                    } label: {
                        Text("-")
                            .font(.system(size: 70))
                            .foregroundColor(.orange)
                            .offset(x: -20, y: -30)
                    }
                    
                    
                    VStack {
                        Image("{G}")
                        
                    }
                    .offset(y: -30)
                    
                    
                    Button {
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
}

#Preview {
    HpCounterView()
}
