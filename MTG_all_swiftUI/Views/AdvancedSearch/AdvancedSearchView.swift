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
    @State private var searchText = ""
    @State private var selectedElement = ""
    @State private var requestProgress = true
    var searchSegments = ["Set","Subtypes","Types","Supertypes","Formats"]
    
    var body: some View {
        VStack {
            Picker("Category", selection: $selectedElement) {
                ForEach(searchSegments, id: \.self) {
                    Text($0)
                        .foregroundStyle(.orange)
                }
            }
            .pickerStyle(.segmented)
            if requestProgress {
                List(searchResults, id: \.self) { set in
                    Text(set.name ?? "")
                        .foregroundStyle(.orange)
                }
            } else {
                ProgressView()
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
        .searchable(text: $searchText)
    }
    
    var searchResults: [SetMTG] {
        if searchText.isEmpty {
            return sets
        } else {
            return sets.filter{$0.name!.contains(searchText) }
        }
    }
}


#Preview {
    AdvancedSearchView()
}
