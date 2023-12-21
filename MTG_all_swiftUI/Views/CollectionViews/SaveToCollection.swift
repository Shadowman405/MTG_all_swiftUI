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
    @State private var showNotification = false
    @ObservedObject private var vm = CardViewModel()
    @State private var collectionName = ""
    @State private var selection: String?
    var card = Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", id: "18468b64-37ef-5e4d-b95a-781265b533a2", uuid: "")
    
    var body: some View {
        ZStack {
            List(vm.collectionData, selection: $selection) { collection in
                    HStack {
                        Text(collection.name)
                        Spacer()
                        Button(action: {
                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                            impactMed.impactOccurred()
                            
                            saveToCollection(collection: collection, card: card)
                            withAnimation {
                                showNotification.toggle()
                            }
                        }, label: {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.green)
                        })
                    }
            }
            .navigationTitle("Save to collection")
            .onAppear(perform: {
                vm.fetchCollectionFromDB()
        })
            
            if showNotification {
                NotifactionView(cardName: card.name ?? "", collectionName: collectionName)
            }
        }
    }
    
    func saveToCollection(collection: Collection, card: Card) {
        vm.addCardToCollection(selectedCollection: collection.name, cardName: card.name ?? "", cardMana: card.manaCost ?? "", cardCMC: card.cmc ?? 1, cardColors: card.colors ?? [""], cardColorIdent: card.colorIdentity
                               ?? [""], cardType: card.type ?? "", cardTypes: card.types ?? [""], cardSubtypes: card.subtypes ?? [""], cardRarity: card.rarity ?? "", cardSetCode: card.setCode ?? "", cardSetName: card.setName ?? "", cardText: card.text ?? "", cardFlavor: card.flavor ?? "", cardArtist: card.artist ?? "", cardNumber: card.number ?? "", cardPower: card.power ?? "", cardTough: card.toughness ?? "", cardLayout: card.layout ?? "", cardMulti: card.multiverseid ?? "", cardImgUrl: card.imageURL ?? "", cardPrintings: card.printings ?? [""], cardOriginTxt: card.originalText ?? "", cardOriginType: card.originalType ?? "", cardId: card.id ?? "", cardUUID: card.uuid ?? "\(UUID())")
    }
}

#Preview {
    SaveToCollection()
}
