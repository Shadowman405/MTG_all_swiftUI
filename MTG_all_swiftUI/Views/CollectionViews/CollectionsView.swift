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
        List{
            ForEach(vm.collectionData) { collection in
                NavigationLink {
                    CardsInCollectionView(collectionName: collection.name)
                } label: {
                    HStack {
                        Text(collection.name)
                            .font(.custom(
                                    "AmericanTypewriter",
                                    fixedSize: 16))
                            .foregroundColor(.orange)
                    }
                }
            }
            .onDelete(perform: { indexSet in
                delete(at: indexSet)
            })
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
                    Button("Save"){vm.saveCollection(collectionName: collectionName)}
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
        .navigationTitle("Collections")
        .onAppear(perform: {
            vm.fetchCollectionFromDB()
        })
    }
    
    func delete(at offsets: IndexSet) {
        let collection = vm.collectionData[offsets.first!]
        vm.deleteCollection(collectionName: collection.name)
    }
}

#Preview {
    CollectionsView()
}
