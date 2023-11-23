//
//  CollectionsView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CollectionsView: View {
    @State private var collections: [Collection] = []
    @State private var showAlert = false
    @ObservedObject private var vm = CardViewModel()
    @State private var collectionName = ""
    
    var body: some View {
        List(vm.collectionData) { collection in
            NavigationLink {
                CardsInCollectionView(cardsInCollection: collection.cards)
            } label: {
                HStack {
                    Text(collection.name)
                    Spacer()
                    Text("\(collection.cards.count)/60")
                }
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
                .alert(Text("Add New Collection"), isPresented: $showAlert) {
                    TextField("Collection name",text: $collectionName)
                        .textInputAutocapitalization(.never)
                    Button("Save"){saveCollection()}
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
        .navigationTitle("Collections")
        .onAppear(perform: {
            vm.fetchCollectionFromDB()
        })
    }
    
    private func saveCollection() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let uniqueID = "\(uid)\(self.collectionName)"
        let collectionData = ["name": collectionName]
        FirebaseManager.shared.firestore.collection("Collections").document(uniqueID).setData(collectionData) { error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            }
    }
}

#Preview {
    CollectionsView()
}
