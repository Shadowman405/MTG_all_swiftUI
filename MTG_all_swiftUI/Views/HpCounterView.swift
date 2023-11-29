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
        ZStack {
            Button {
                print("HP")
            } label: {
                ZStack {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .circular)
                        .frame(height: 100)
                    //.padding()
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(height: 100)
                        .foregroundStyle(LinearGradient(colors: [Color(.orange), Color(.purple)], startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.degrees(rotation))
                        .mask {
                            RoundedRectangle(cornerRadius: 20,style: .continuous)
                            .stroke(lineWidth: 3)                }
                }
            }
            .onAppear(perform: {
                withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            })
        }
    }
}

#Preview {
    HpCounterView()
}
