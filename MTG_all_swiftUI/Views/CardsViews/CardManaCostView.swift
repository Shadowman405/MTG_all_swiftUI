//
//  CardManaCostView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 17.11.23.
//

import SwiftUI

struct CardManaCostView: View {
    var card = Card(name: "Abzan Falconer", manaCost: "{1}{B}{B}{B}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", id: "18468b64-37ef-5e4d-b95a-781265b533a2", uuid: "")
    @State var imagesArr = [""]
    
    var body: some View {
        ForEach(0..<imagesArr.count, id: \.self) { imageName in
            Image(imagesArr[imageName])
                .resizable()
                .frame(width: 20, height: 20)
        }
        .onAppear(perform: {
            imagesArr = splitString(card.manaCost ?? "")
        })
    }
    
    func splitString(_ str: String) -> [String] {
        var newStrArr = [String]()
        let items = str.split(separator: "}", omittingEmptySubsequences: true)
        for item in items {
            let newStr = item + "}"
            newStrArr.append(String(newStr))
        }
        return newStrArr
    }
}

#Preview {
    CardManaCostView()
}
