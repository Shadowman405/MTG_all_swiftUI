//
//  NotifactionView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 21.12.23.
//

import SwiftUI

struct NotifactionView: View {
    var cardName = "Szarekh"
    var collectionName = "W40k"
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 70)
                .foregroundStyle(.black)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.orange, lineWidth: 3)
                }
            
            Text("\(cardName) added to \(collectionName) collection")
                .foregroundStyle(.orange)
        }
        .padding()
    }
}

#Preview {
    NotifactionView()
}
