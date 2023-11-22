//
//  SaveToCollection.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 21.11.23.
//

import SwiftUI

struct SaveToCollection: View {
    //@State private var collections: [Collection] = []
    @State private var showAlert = false
    @ObservedObject private var vm = CardViewModel()
    @State private var collectionName = ""
    
    var body: some View {
        List(vm.collectionData) { collection in
                HStack {
                    Text(collection.name)
                    Spacer()
                    Button(action: {
                        print("Saved to \(collection.name) collection")
                    }, label: {
                        //Text("Save")
                        Image(systemName: "plus.circle")
                            .foregroundColor(.green)
                    })
                }
        }
        .navigationTitle("Save to collection")
        .onAppear(perform: {
            vm.fetchCollectionFromDB()
        })
    }
}

#Preview {
    SaveToCollection()
}
