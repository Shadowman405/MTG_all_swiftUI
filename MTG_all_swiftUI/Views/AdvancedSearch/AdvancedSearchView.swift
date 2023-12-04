//
//  AdvancedSearchView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 4.12.23.
//

import SwiftUI

struct AdvancedSearchView: View {
    @StateObject var vm = CardViewModel()
    @State private var sets: [Set] = []
    
    var body: some View {
        List(sets, id: \.self) { set in
            Text(set.name ?? "")
        }
        .navigationTitle("Advanced Search")
        .onAppear {
            if vm.setsData.isEmpty  {
                Task{
                    print("Sets")
                    await vm.fetchSets()
                    sets = vm.fileteredSetsData
                    print(sets)
                }
            }
        }
    }
}

#Preview {
    AdvancedSearchView()
}
