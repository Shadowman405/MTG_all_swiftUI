//
//  CardSingleCell.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 16.11.23.
//

import SwiftUI

struct CardSingleCell: View {
    var card : Card
    @State private var rotation:CGFloat = 0.0
    
    var body: some View {
//        AsyncImage(url: URL(string: card.imageURL ?? "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card")) { image in
//            image.resizable()
//                .aspectRatio(contentMode: .fill)
//            //.padding()
//                .border(.gray, width: 3)
//        } placeholder: {
//            Image("card_placeholder")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .border(.gray, width: 3)
//        }
        ZStack {
            RoundedRectangle(cornerSize: CGSize(width: 20, height: 10), style: .circular)
                .frame(height: 100)
                //.padding()
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(height: 100)
                .foregroundStyle(LinearGradient(colors: [Color(.orange), Color(.purple)], startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    RoundedRectangle(cornerRadius: 20,style: .continuous)
                        .stroke(lineWidth: 3)
                        .frame()
                }
            
            ZStack {
                HStack {
                    
                    Text(card.name ?? "")
                        .foregroundColor(.black)
//                    Text(card.manaCost ?? "")
//                        .foregroundColor(.black)
                    Image("{B}")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
            }
        }
        .onAppear(perform: {
            withAnimation(.linear(duration: 4).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        })
    }
}

#Preview {
    CardSingleCell(card: MockDataManager().mockCard)
}
