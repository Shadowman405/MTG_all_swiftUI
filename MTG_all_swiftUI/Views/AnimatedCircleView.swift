//
//  AnimatedCircleView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 29.11.23.
//

import SwiftUI

struct AnimatedCircleView: View {
    @State private var rotation = false

    var body: some View {
        TimelineView(.animation){ context in
            let period = 1.0
            let degrees = context.date.timeIntervalSinceReferenceDate.remainder(dividingBy: period) * 360
            Circle()
                .trim(from: 0,to: 0.8)
                .stroke(
                    AngularGradient.init(gradient: .init(colors: [Color.orange, Color.blue, Color.green, Color.purple]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/),style: StrokeStyle(lineWidth: 2, lineCap: .round)
                )
                .rotationEffect(.degrees(degrees))
                .frame(width: 40,height: 40)
            
        }
    }
}

#Preview {
    AnimatedCircleView()
}
