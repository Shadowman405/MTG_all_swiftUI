//
//  CardSingleCell.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 16.11.23.
//

import SwiftUI

struct CardSingleCell: View {
    var card : Card
    
    var body: some View {
        AsyncImage(url: URL(string: card.imageURL ?? "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card")) { image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
            //.padding()
                .border(.gray, width: 3)
        } placeholder: {
            Image("card_placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .border(.gray, width: 3)
        }
    }
}

#Preview {
    CardSingleCell(card: MockDataManager().mockCard)
}
