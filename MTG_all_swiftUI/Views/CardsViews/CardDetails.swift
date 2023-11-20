//
//  CardDetails.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 13.11.23.
//

import SwiftUI
import CachedAsyncImage

struct CardDetails: View {
    var card = Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", legalities: [LegalityElement(format: "Commander", legality: .legal)], id: "18468b64-37ef-5e4d-b95a-781265b533a2")
    @StateObject var vm = CardViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                CachedAsyncImage(url: URL(string: card.imageURL ?? "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400 ,height: 400)
                } placeholder: {
                    Image("card_placeholder")
                        .resizable()
                        .frame(width: 400 ,height: 400)
                        .aspectRatio(contentMode: .fit)
                }
                Divider()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Name: " + card.name!)
                        .font(.custom(
                                "AmericanTypewriter",
                                fixedSize: 24))
                    Text("Set: " + card.setName!)
                        .font(.custom(
                                "AmericanTypewriter",
                                fixedSize: 24))
                    HStack {
                        Text("Mana Cost: ")
                            .font(.custom(
                                    "AmericanTypewriter",
                                    fixedSize: 24))
                        CardManaCostView(card: card)
                    }
                    
                    Divider()
                    Text("Card description: \n" + card.text!)
                        .font(.custom(
                                "AmericanTypewriter",
                                fixedSize: 24))
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle(card.name ?? "Card")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Add to collection")
                } label: {
                    Label("Add", systemImage: "plus.circle")
                        .foregroundColor(.orange)
                }
            }
        }
    }
}

#Preview {
    CardDetails()
}
