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
    @State private var selection: String?
    var card = Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", legalities: [LegalityElement(format: "Commander", legality: .legal)], id: "18468b64-37ef-5e4d-b95a-781265b533a2")
    
    var body: some View {
        List(vm.collectionData, selection: $selection) { collection in
                HStack {
                    Text(collection.name)
                    Spacer()
                    Button(action: {
                        print("Saved to \(collection.name) collection")
                        print(card)
                        vm.addCardToCollection(selectedCollection: collection.name, cardName: card.name ?? "", cardMana: card.manaCost ?? "", cardCMC: card.cmc ?? 1, cardColors: card.colors ?? [""], cardColorIdent: card.colorIdentity
                                               ?? [""], cardType: card.type ?? "", cardTypes: card.types ?? [""], cardSubtypes: card.subtypes ?? [""], cardRarity: card.rarity ?? "", cardSetCode: card.setCode ?? "", cardSetName: card.setName ?? "", cardText: card.text ?? "", cardFlavor: card.flavor ?? "", cardArtist: card.artist ?? "", cardNumber: card.number ?? "", cardPower: card.power ?? "", cardTough: card.toughness ?? "", cardLayout: card.layout ?? "", cardMulti: card.multiverseid ?? "", cardImgUrl: card.imageURL ?? "", cardPrintings: card.printings ?? [""], cardOriginTxt: card.originalText ?? "", cardOriginType: card.originalType ?? "", cardLegality: card.legalities ?? [LegalityElement(format: "", legality: .legal)], cardId: card.id ?? "")
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
