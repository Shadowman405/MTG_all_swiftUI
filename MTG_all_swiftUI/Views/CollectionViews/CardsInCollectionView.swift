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
    @State private var onEdit = false
    
    var body: some View {
        if onEdit {
            onEditTrue
        } else {
            onEditFalse
        }
    }
    
    var onEditFalse: some View {
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
                    .onDelete(perform: { indexSet in
                        print(indexSet)
                    })
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onEdit.toggle()
                } label: {
                    Label("Edit", systemImage: "slider.horizontal.3")
                        .foregroundColor(.orange)
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
    
    var onEditTrue: some View {
        List{
            ForEach(groupByName(vm.cardsTestSubColl), id: \.0){ pair in
                Section(header: Text(pair.0 ?? "")) {
                    ForEach(pair.1) { card in
                            HStack {
                                Text(card.name ?? "")
                                    .font(.custom(
                                            "AmericanTypewriter",
                                            fixedSize: 16))
                                .foregroundColor(.orange)
                                Button {
                                    vm.deleteFromCollection(collectionName: collectionName, cardUUID: card.uuid ?? "")
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }

                            }
                    }
                    .onDelete(perform: { indexSet in
                        print(indexSet)
                    })
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onEdit.toggle()
                } label: {
                    Label("Edit", systemImage: "slider.horizontal.3")
                        .foregroundColor(.orange)
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
