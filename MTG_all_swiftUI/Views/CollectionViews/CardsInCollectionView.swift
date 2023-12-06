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
    //var cardsInCollection: [Card] = []
    @State private var onEdit = false
    
    
    var body: some View {
        ZStack {
            if onEdit {
                onEditTrue
            } else {
                onEditFalse
            }
        }
        .animation(.easeInOut)
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
                }
            }
        }
        //.transition(.slide)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        onEdit.toggle()
                    }
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
                                
                                Spacer()
                                
                                Button {
                                    let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                    impactMed.impactOccurred()
                                    
                                    vm.deleteFromCollection(collectionName: collectionName, cardUUID: card.uuid ?? "")
                                    delaySwitch()
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                    }
                }
            }
        }
        //.transition(.slide)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    withAnimation {
                        onEdit.toggle()
                    }
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
    
    private func groupByName(_ cards: [Card]) -> [(String?, [Card])]{
        let grouped = Dictionary(grouping: cards, by: {$0.name})
        return grouped.sorted(by: {$0.key! < $1.key!})
    }
    
    private func delaySwitch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            vm.returnSubCollectionCard(colName: collectionName)
            onEdit.toggle()
        }
        onEdit.toggle()
    }
}

#Preview {
    CardsInCollectionView()
}
