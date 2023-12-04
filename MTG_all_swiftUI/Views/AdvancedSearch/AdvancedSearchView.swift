//
//  AdvancedSearchView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 4.12.23.
//

import SwiftUI

struct AdvancedSearchView: View {
    @StateObject var vm = CardViewModel()
    @State private var sets: [SetMTG] = []
    
    var body: some View {
        VStack {
            List(vm.fileteredSetsData, id: \.self) { set in
                Text(set.name ?? "")

            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        Task{
                            await vm.fetchSets()
                        }
                    } label: {
                        Text("Fetch")
                            .foregroundColor(.orange)
                    }
                }
        }
            .onAppear {
                Task{
                    print("Sets")
                    await vm.fetchSets()
                    sets = vm.fileteredSetsData
                    print(sets)
                }
            }
            .navigationTitle("Advanced Search")
        }
    }
}


#Preview {
    AdvancedSearchView()
}
