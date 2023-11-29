//
//  HpCounterView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI

struct HpCounterView: View {
    @State private var rotation:CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .overlay(.black)
                    .ignoresSafeArea()
                Image("{W}")
                    .offset(y: 10)
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
                Image("{G}")
                    .offset(y: -30)
            }
        }
    }
}

#Preview {
    HpCounterView()
}
