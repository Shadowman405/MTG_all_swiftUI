//
//  CardsInCollectionView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI

struct CardsInCollectionView: View {
    var cardsInCollection: [Card] = []
    
    var body: some View {
        List(cardsInCollection) { card in
            Text(card.name ?? "")
        }
    }
}

#Preview {
    CardsInCollectionView()
}
