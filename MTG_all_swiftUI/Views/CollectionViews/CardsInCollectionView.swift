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
            NavigationLink {
                CardDetails(card: card)
            } label: {
                Text(card.name ?? "")
            }
        }
        .listStyle(.sidebar)
    }
    
    func groupByName(_ cards: [Card]) -> [(String?, [Card])]{
        let grouped = Dictionary(grouping: cards, by: {$0.name})
        return grouped.sorted(by: {$0.key! < $1.key!})
    }
}

#Preview {
    CardsInCollectionView()
}
