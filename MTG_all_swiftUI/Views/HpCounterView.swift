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
        HStack {
            Button {
                print("HP")
            } label: {
                ZStack {
                    Image("{B}")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .background(Color.orange)
                    .clipShape(Circle())
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(LinearGradient(colors: [Color(.orange), Color(.purple)], startPoint: .top, endPoint: .bottom))
                        .rotationEffect(.degrees(rotation))
                        .mask {
                            Circle()
                                .stroke(lineWidth: 3)
                        }
                }
            }
        }
    }
}

#Preview {
    HpCounterView()
}
