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
            
            Text("\(cardName) added to \(collectionName) collection")
                .foregroundStyle(.green)
        }
        .padding()
    }
}

#Preview {
    NotifactionView()
}
