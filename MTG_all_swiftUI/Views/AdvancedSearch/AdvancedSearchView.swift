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
    //
    @Binding var searhUrlString: String
    @State private var setSelected = ""
    @State private var setCodeSelected = ""
    @State private var subtypeSelected = ""
    @State private var typeSelected = ""
    @State private var superTypeSelected = ""
    @State private var formatSelected = ""
    
    var body: some View {
        VStack {
            Picker("Category", selection: $selectedElement) {
                ForEach(vm.searchSegments, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            
            
            if selectedElement == "Set" {
                VStack {
                    Text("Selected set: \(setSelected)")
                        .foregroundStyle(.orange)
                    List(searchResultsSets, id: \.self) { set in
                        Button {
                            setSelected = set.name ?? ""
                            setCodeSelected = String("&set=" + (set.code ?? ""))
//                            searhUrlString.append("?&set=\(set.code ?? "")")
                        } label: {
                            Text(set.name ?? "")
                                .foregroundStyle(.orange)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            } else if selectedElement ==  "Subtypes" {
                VStack {
                    Text("Selected Subtype: \(subtypeSelected)")
                        .foregroundStyle(.orange)
                    List(searchResultsSubs, id: \.self){ sub in
                        Button {
                            subtypeSelected = String("&subtypes=" + (sub))
                        } label: {
                            Text(sub)
                                .foregroundStyle(.orange)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            } else if selectedElement == "Types" {
                VStack{
                    Text("Selected Type: \(typeSelected)")
                        .foregroundStyle(.orange)
                    List(searchResultsTypes, id: \.self) { type in
                        Button {
                            typeSelected = String("&types=" + (type))
                        } label: {
                            Text(type)
                                .foregroundStyle(.orange)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            } else if selectedElement == "Supertypes" {
                VStack {
                    Text("Selected Supertype: \(superTypeSelected)")
                        .foregroundStyle(.orange)
                    List(searchResultsSupertypes, id: \.self) { supertype in
                        Button {
                            superTypeSelected = String("&supertypes=" + (supertype))
                        } label: {
                            Text(supertype)
                                .foregroundStyle(.orange)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            } else {
                VStack {
                    Text("Selected Format: \(formatSelected)")
                        .foregroundStyle(.orange)
                    List(searchResultsFormats, id: \.self) { format in
                        Button {
                            formatSelected = String("&fromat=" + (format))
                        } label: {
                            Text(format)
                                .foregroundStyle(.orange)
                        }
                        .buttonStyle(.borderless)
                    }
                }
            }
        }
        .onDisappear(perform: {
            searhUrlString = "https://api.magicthegathering.io/v1/cards?\(setCodeSelected)\(subtypeSelected)\(typeSelected)\(superTypeSelected)\(formatSelected)&name="
        })
        .onAppear {
            Task{
                if vm.fileteredSetsData.isEmpty {
                    await vm.fetchSets()
                    sets = vm.fileteredSetsData
                }
                if vm.fileteredSubtypesData.subtypes.isEmpty {
                    await vm.fetchSubtypes()
                    subtypes = vm.fileteredSubtypesData
                }
                if vm.fileteredTypesData.types.isEmpty {
                    await vm.fetchTypes()
                    types = vm.fileteredTypesData
                }
                if vm.fileteredSupertypesData.supertypes.isEmpty {
                    await vm.fetchSupertypes()
                    supertypes = vm.fileteredSupertypesData
                }
                if vm.fileteredFormatsData.formats.isEmpty {
                    await vm.fetchFormats()
                    formats = vm.fileteredFormatsData
                }
            }
        }
        .navigationTitle("Advanced Search")
        .searchable(text: $searchText)
    }
}


#Preview {
    AdvancedSearchView(searhUrlString: .constant(""))
}


//MARK: - Extension
extension AdvancedSearchView {
    //MARK: - search variables
    
    //Sets
    var searchResultsSets: [SetMTG] {
        if searchText.isEmpty {
            return sets
        } else {
            return sets.filter{$0.name!.contains(searchText) }
        }
    }
    //Subtypes
    var searchResultsSubs: [String] {
        if searchText.isEmpty {
            return subtypes.subtypes
        } else {
            return subtypes.subtypes.filter{$0.contains(searchText) }
        }
    }
    //Types
    var searchResultsTypes: [String] {
        if searchText.isEmpty {
            return types.types
        } else {
            return types.types.filter{$0.contains(searchText) }
        }
    }
    //Supertypes
    var searchResultsSupertypes: [String] {
        if searchText.isEmpty {
            return supertypes.supertypes
        } else {
            return supertypes.supertypes.filter{$0.contains(searchText) }
        }
    }
    //Formats
    var searchResultsFormats: [String] {
        if searchText.isEmpty {
            return formats.formats
        } else {
            return formats.formats.filter{$0.contains(searchText) }
        }
    }
}
