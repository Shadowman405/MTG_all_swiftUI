//
//  MyOwnCards.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 22.03.24.
//

import SwiftUI

struct MyOwnCards: View {
    @State private var showAddOwnCard = false
    @State private var myOwnCards: [Card] = [Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", id: "18468b64-37ef-5e4d-b95a-781265b533a2", uuid: "")]
    @StateObject var vm = CardViewModel()

    
    var body: some View {
        ZStack {
            List(myOwnCards) { card in
                HStack {
                    Text(card.name ?? "")
                    CardManaCostView(card: card)
                }
            }
        }
        .navigationTitle("My Cards")
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    if #available(iOS 17.0, *) {
                        AddOwnCardView()
                    } else {
                        // Fallback on earlier versions
                    }
                } label: {
                    Label("Add Own Card", systemImage: "menucard")
                        .foregroundColor(.orange)
                }
                Button  {
                    showAddOwnCard.toggle()
                } label: {
                    Label("Advanced Search", systemImage: "menucard")
                        .foregroundColor(.orange)
                }
            }
        })
    }
} 

#Preview {
    MyOwnCards()
}
