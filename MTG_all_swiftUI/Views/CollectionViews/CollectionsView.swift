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
    @StateObject var vm = CardViewModel()
    @State private var collectionName = ""
    
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
            collections = [Collection(name: "Mono White",cards: vm.mockCards), Collection(name: "Mono Black",cards: vm.mockCards)]
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
