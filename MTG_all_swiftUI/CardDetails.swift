//
//  CardDetails.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 13.11.23.
//

import SwiftUI

struct CardDetails: View {
    var card = Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", legalities: [LegalityElement(format: "Commander", legality: .legal)], id: "18468b64-37ef-5e4d-b95a-781265b533a2")
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                AsyncImage(url: URL(string: card.imageURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    Image("card_placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Name: " + card.name)
                    Text("Set: " + card.setName)
                    Text("Mana Cost: " + card.manaCost)
                    Text(card.text)
                }
            }
            .padding()
        }
        .navigationTitle(card.name)
    }
}

#Preview {
    CardDetails()
}
