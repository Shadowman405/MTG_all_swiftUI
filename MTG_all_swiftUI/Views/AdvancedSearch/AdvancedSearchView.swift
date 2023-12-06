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
    @State private var subtypes = SubtypeMTG(subtypes: [String]())
    @State private var types = TypesMTG(types: [String]())
    @State private var supertypes = SupertypesMTG(supertypes: [String]())
    @State private var formats = FormatsMTG(formats: [String]())
    @State private var searchText = ""
    @State private var selectedElement = "Set"
    @State private var requestProgress = true
    var searchSegments = ["Set","Subtypes","Types","Supertypes","Formats"]
    
    var body: some View {
        VStack {
            Picker("Category", selection: $selectedElement) {
                ForEach(searchSegments, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            
            if selectedElement == "Set" {
                List(searchResultsSets, id: \.self) { set in
                    Text(set.name ?? "")
                        .foregroundStyle(.orange)
                }
            } else if selectedElement ==  "Subtypes" {
                List(searchResultsSubs, id: \.self) { subtype in
                    Text(subtype)
                        .foregroundStyle(.orange)
                }
            } else if selectedElement == "Types" {
                List(types.types, id: \.self) { type in
                    Text(type)
                        .foregroundStyle(.orange)
                }
            } else if selectedElement == "Supertypes" {
                List(supertypes.supertypes, id: \.self) { supertype in
                    Text(supertype)
                        .foregroundStyle(.orange)
                }
            } else {
                List(formats.formats, id: \.self) { format in
                    Text(format)
                        .foregroundStyle(.orange)
                }
            }
        }
        .onAppear {
            Task{
                await vm.fetchSets()
                sets = vm.fileteredSetsData
                await vm.fetchSubtypes()
                subtypes = vm.fileteredSubtypesData
                await vm.fetchTypes()
                types = vm.fileteredTypesData
                await vm.fetchSupertypes()
                supertypes = vm.fileteredSupertypesData
                await vm.fetchFormats()
                formats = vm.fileteredFormatsData
            }
        }
        .navigationTitle("Advanced Search")
        .searchable(text: $searchText)
    }
}


#Preview {
    AdvancedSearchView()
}

extension AdvancedSearchView {
    var searchResultsSets: [SetMTG] {
        if searchText.isEmpty {
            return sets
        } else {
            return sets.filter{$0.name!.contains(searchText) }
        }
    }
    
    var searchResultsSubs: [String] {
        if searchText.isEmpty {
            return subtypes.subtypes
        } else {
            return subtypes.subtypes.filter{$0.contains(searchText) }
        }
    }
}
