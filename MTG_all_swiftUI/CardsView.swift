//
//  CardsView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI

struct CardsView: View {
    @State private var cards = [Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", legalities: [LegalityElement(format: "Commander", legality: .legal)], id: "18468b64-37ef-5e4d-b95a-781265b533a2"),Card(name: "Doomed Traveler", manaCost: "{W}", cmc: 1, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: [""], subtypes: [""], rarity: "Rare", setCode: "2X2", setName: "Double Masters 2022", text: "", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571342&type=card", printings: [""], originalText: "", originalType: "", legalities: [LegalityElement(format: "Commander", legality: .legal)], id: "270cb060-9fcf-5a5a-b87e-6ec5a0e278b5")]
    
    var body: some View {
        List{
            ForEach(cards) {card in
                VStack {
                    AsyncImage(url: URL(string: card.imageURL))
                        .frame(width: 350, height: 350)
                        .padding()
                    //Text(card.name)
                }
            }
        }
        
    }
}

#Preview {
    CardsView()
}
