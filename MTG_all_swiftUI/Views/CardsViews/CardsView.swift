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
    @State private var mainUrl = ""
//    @State private var mainUrl = "https://api.magicthegathering.io/v1/cards?&set=30A&name="
    @State private var showAdvancedSearch = false
    @State private var requestProgress = true
    private var startAppUrl = "https://api.magicthegathering.io/v1/cards"
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        List(searchResults) {card  in
            if requestProgress {
                NavigationLink {
                    CardDetails(showButtons: true, card: card)
                } label: {
                    HStack {
                        Text(card.name ?? "")
                        CardManaCostView(card: card)
                    }
                }
            } else {
                ProgressView()
            }
        }
        .searchable(text: $searchText)
        .navigationTitle("Cards")
        .onChange(of: searchText) { value in
            Task {
                requestProgress = false
                vm.fileteredCardData = []
                await vm.fetchCardsSearch(mainUrl: mainUrl ,searchString: value)
                cards = vm.fileteredCardData
                requestProgress = true
            }
        }
        .onAppear {
                Task{
                    vm.fileteredCardData = []
//                    await vm.fetchCards(with: mainUrl)
                    await vm.fetchCards(with: startAppUrl)
                    cards = vm.fileteredCardData
                    print(mainUrl)
                }
        }
        .onChange(of: mainUrl, perform: { value in
            Task{
                vm.fileteredCardData = []
                await vm.fetchCards(with: mainUrl)
                cards = vm.fileteredCardData
                print(mainUrl)
            }
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    AdvancedSearchView(searhUrlString: $mainUrl)
                } label: {
                    Label("Advanced Search", systemImage: "magnifyingglass.circle.fill")
                        .foregroundColor(.orange)
                }
                Button  {
                    showAdvancedSearch.toggle()
                    print(mainUrl)
                } label: {
                    Label("Advanced Search", systemImage: "magnifyingglass.circle.fill")
                        .foregroundColor(.orange)
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
