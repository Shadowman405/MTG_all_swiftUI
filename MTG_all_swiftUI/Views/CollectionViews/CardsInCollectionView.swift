//
//  CardsInCollectionView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI

struct CardsInCollectionView: View {
    @ObservedObject private var vm = CardViewModel()
    var collectionName = ""
    var cardsInCollection: [Card] = []
    
    var body: some View {
        List{
            ForEach(groupByName(vm.cardsTestSubColl), id: \.0){ pair in
                Section(header: Text(pair.0 ?? "")) {
                    ForEach(pair.1) { card in
                        NavigationLink {
                            CardDetails(showButtons: false ,card: card)
                        } label: {
                            Text(card.name ?? "")
                                .font(.custom(
                                        "AmericanTypewriter",
                                        fixedSize: 16))
                                .foregroundColor(.orange)
                        }

                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Cards in collection - \(vm.cardsTestSubColl.count)")
        .listStyle(.sidebar)
        .onAppear{
            vm.returnSubCollectionCard(colName: collectionName)
        }
    }
    
    func groupByName(_ cards: [Card]) -> [(String?, [Card])]{
        let grouped = Dictionary(grouping: cards, by: {$0.name})
        return grouped.sorted(by: {$0.key! < $1.key!})
    }
}

#Preview {
    CardsInCollectionView()
}
