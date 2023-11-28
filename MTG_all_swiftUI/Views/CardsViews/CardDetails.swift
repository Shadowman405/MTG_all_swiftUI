//
//  CardDetails.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 13.11.23.
//

import SwiftUI
import CachedAsyncImage

struct CardDetails: View {
    var showButtons = false
    var card = MockDataManager().mockCard
    @StateObject var vm = CardViewModel()
    
    var body: some View {
        if showButtons {
            viewWithBtns
        } else {
            viewWithoutBtns
        }
    }
    
    //MARK: - View Without links and buttons
    var viewWithBtns: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                CachedAsyncImage(url: URL(string: card.imageURL ?? "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card")) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400 ,height: 400)
                } placeholder: {
                    Image("card_placeholder")
                        .resizable()
                        .frame(width: 265 ,height: 370)
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
                
                NavigationLink {
                    SaveToCollection(card: card)
                } label: {
                        HStack {
                            Text("Add to Collection")
                            Image(systemName: "rectangle.stack.fill.badge.plus")
                        }
                }
                .padding()
            }
            .padding()
        }
        .navigationTitle(card.name ?? "Card")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SaveToCollection(card: card)
                } label: {
                    Label("Add", systemImage: "rectangle.stack.fill.badge.plus")
                        .foregroundColor(.orange)
                }
            }
        }
    }
    
    //MARK: - View Without links and buttons
    var viewWithoutBtns: some View {
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
    }
}

#Preview {
    CardDetails()
}
