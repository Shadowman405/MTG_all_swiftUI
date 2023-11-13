//
//  NetworkCall.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 13.11.23.
//

import Foundation

class NetworkCall: ObservableObject {
    @Published var cards = [Card]()
    
    private var cardsUrl = "https://api.magicthegathering.io/v1/cards?&set=40K"
    
    func loadCardsData(completion: @escaping (CardsMTG) -> ()) {
        guard let url = URL(string: cardsUrl) else { print("Bad url,,,,"); return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                let cards = try JSONDecoder().decode(CardsMTG.self, from: data!)
                DispatchQueue.main.async {
                    completion(cards)
                }
            } catch {
                debugPrint(error)
            }
        }
        .resume()
    }
}
