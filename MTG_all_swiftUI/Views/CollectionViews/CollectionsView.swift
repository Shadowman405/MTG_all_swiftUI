//
//  CollectionsView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI

struct CollectionsView: View {
    @State private var collections: [Collection] = []
    @State private var showAlert = false
    @StateObject var vm = CardViewModel()
    
    var body: some View {
//        HStack{
//            Text("Collections")
//            Image("W")
//                .resizable()
//                .frame(width: 40, height: 40)
//        }
//        
        List(collections) { collection in
            NavigationLink {
                CardsInCollectionView(cardsInCollection: collection.cards)
            } label: {
                Text(collection.name)
            }

        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Add collection")
                    showAlert = true
                } label: {
                    Label("Add", systemImage: "plus.circle")
                        .foregroundColor(.orange)
                }
                .alert(Text("Save Collection"), isPresented: $showAlert) {
                    Button("Save"){}
                    Button("Cancel") {}
                }
            }
        }
        .navigationTitle("Collections")
        .onAppear(perform: {
            collections = [Collection(name: "Mono White",cards: vm.mockCards), Collection(name: "Mono Black",cards: vm.mockCards)]
        })
    }
}

#Preview {
    CollectionsView()
}
