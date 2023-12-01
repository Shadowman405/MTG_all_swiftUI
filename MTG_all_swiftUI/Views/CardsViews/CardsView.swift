//
//  CardsView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI

struct CardsView: View {
    @StateObject var vm = CardViewModel()
    @State private var cards: [Card] = []
    @State private var searchText = ""
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        List(searchResults) {card  in
            NavigationLink {
                CardDetails(showButtons: true, card: card)
            } label: {
                //CardSingleCell(card: card)
                HStack {
                    Text(card.name ?? "")
                    CardManaCostView(card: card)
                }
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Cards")
        .onChange(of: searchText) { value in
            Task {
                vm.fileteredCardData = []
                await vm.fetchCardsSearch(searchString: value)
                cards = vm.fileteredCardData
            }
        }
        .onAppear {
            if vm.fileteredCardData.isEmpty  {
                Task{
                    await vm.fetchCards()
                    cards = vm.fileteredCardData
                }
            }
        }
    }
    
    var searchResults: [Card] {
        if searchText.isEmpty {
            return cards
        } else {
            return cards.filter{$0.name!.contains(searchText) }
        }
    }
}

#Preview {
    CardsView()
}
