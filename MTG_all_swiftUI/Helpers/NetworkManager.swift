//
//  NetworkManager.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import Foundation
import Firebase

enum NetworkError: Error {
    case badUrl
    case invaledRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WebService{
    func downloadData<T: Codable>(fromURL: String) async -> T? {
        do {
            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl}
            let (data,response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse else {throw NetworkError.badResponse}
            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus}
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedResponse = try? decoder.decode(T.self, from: data)
            
            return decodedResponse
            
        } catch NetworkError.badUrl {
            print("Problem with URL")
        } catch NetworkError.badResponse {
            print("bad response")
        } catch NetworkError.badStatus {
            print("Bad status")
        } catch NetworkError.failedToDecodeResponse{
            print("Cant decode data")
        } catch {
            debugPrint(error.localizedDescription)
        }
        
        return nil
    }
}


class CardViewModel: ObservableObject {
    var cardData = [Card]()
    
    var mockCards = [Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", legalities: [LegalityElement(format: "Commander", legality: .legal)], id: "18468b64-37ef-5e4d-b95a-781265b533a2"), Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", legalities: [LegalityElement(format: "Commander", legality: .legal)], id: "18468b64-37ef-5e4d-b95a-781265b533a2")]
    
    
    @Published var fileteredCardData = [Card]()
    
    //MARK: - CARDS
    private var cardsUrl = "https://api.magicthegathering.io/v1/cards?&set=40K"
    
    func fetchCards() async {
        guard let downloadCard: CardsMTG = await WebService().downloadData(fromURL: cardsUrl) else { return }
        cardData = downloadCard.cards
        
        DispatchQueue.main.async { [self] in
            for card in cardData {
                if card.imageURL != nil {
                    let cardString: String = card.imageURL?.replacingOccurrences(of: "http", with: "https") ?? ""
                    fileteredCardData.append(Card(name: card.name, manaCost: card.manaCost, cmc: card.cmc, colors: card.colors, colorIdentity: card.colorIdentity, type: card.type, types: card.types, subtypes: card.subtypes, rarity: card.rarity, setCode: card.setCode, setName: card.setName, text: card.text, flavor: card.flavor, artist: card.artist, number: card.number, power: card.power, toughness: card.toughness, layout: card.layout, multiverseid: card.multiverseid, imageURL: cardString, printings: card.printings, originalText: card.originalText, originalType: card.originalType, legalities: card.legalities, id: card.id))
                    print(cardString)
                } else {
                    print(card.name!)
                }
            }
            
            for _ in fileteredCardData {
                //print(image.imageURL!)
                print(fileteredCardData.count)
                print(cardData.count)
            }
        }
    }
    
    func fetchCardsSearch(searchString: String) async {
        var cardsUrlSearch = "https://api.magicthegathering.io/v1/cards?&name=" + searchString
        guard let downloadCard: CardsMTG = await WebService().downloadData(fromURL: cardsUrl) else { return }
        cardData = downloadCard.cards
        
        DispatchQueue.main.async { [self] in
            for card in cardData {
                if card.imageURL != nil {
                    let cardString: String = card.imageURL?.replacingOccurrences(of: "http", with: "https") ?? ""
                    fileteredCardData.append(Card(name: card.name, manaCost: card.manaCost, cmc: card.cmc, colors: card.colors, colorIdentity: card.colorIdentity, type: card.type, types: card.types, subtypes: card.subtypes, rarity: card.rarity, setCode: card.setCode, setName: card.setName, text: card.text, flavor: card.flavor, artist: card.artist, number: card.number, power: card.power, toughness: card.toughness, layout: card.layout, multiverseid: card.multiverseid, imageURL: cardString, printings: card.printings, originalText: card.originalText, originalType: card.originalType, legalities: card.legalities, id: card.id))
                    print(cardString)
                } else {
                    print(card.name!)
                }
            }
            
            for _ in fileteredCardData {
                //print(image.imageURL!)
                print(fileteredCardData.count)
                print(cardData.count)
            }
        }
    }
    
    //MARK: - Collections
    var collectionData = [Collection]()
    
    func fetchCollectionFromDB() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
        FirebaseManager.shared.firestore.collection("Collecions").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            let doc = snapshot!.documents
            print(doc)
        }
    }
}

