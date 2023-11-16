//
//  CardsView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI

struct CardsView: View {
    @StateObject var vm = CardViewModel()
    @State private var cards = [MockDataManager().mockCard]
    @State private var searchText = ""
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(cards) { card in
                    NavigationLink {
                        CardDetails(card: card)
                    } label: {
                        CardSingleCell(card: card)
                    }
                }
            }
            .padding()
        }
        .searchable(text: $searchText)
        .navigationTitle("Cards")
        .onAppear {
            if vm.fileteredCardData.isEmpty {
                Task{
                    await vm.fetchCards()
                    cards = vm.fileteredCardData
                }
            }
        }
    }
}

#Preview {
    CardsView()
}
