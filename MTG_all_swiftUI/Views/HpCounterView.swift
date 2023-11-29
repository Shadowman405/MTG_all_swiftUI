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
                    Image("{B}")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .background(Color.orange)
                    .clipShape(Circle())
            }
            
            AnimatedCircleView()
        }
    }
}

#Preview {
    HpCounterView()
}
