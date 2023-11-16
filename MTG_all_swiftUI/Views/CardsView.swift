//
//  CardsView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI

struct CardsView: View {
    @StateObject var vm = CardViewModel()
    
    @State private var cards = [MockDataManager().mockCard]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(cards) { card in
                    NavigationLink {
                        CardDetails(card: card)
                    } label: {
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
            }
            .padding()
        }
        .navigationTitle("Cards")
        .onAppear {
            if vm.fileteredCardData.isEmpty {
                Task{
                    await vm.fetchCards()
                    cards = vm.fileteredCardData
                }
            }
        }
    }
}

#Preview {
    CardsView()
}
