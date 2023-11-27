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
    
    var mockCards = [Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", id: "18468b64-37ef-5e4d-b95a-781265b533a2", uuid: ""), Card(name: "Abzan Falconer", manaCost: "{2}{W}", cmc: 3, colors: ["W"], colorIdentity: ["W"], type: "Creature — Human Soldier", types: ["Creature"], subtypes: ["Human", "Soldier"], rarity: "Uncommon", setCode: "2X2", setName: "Double Masters 2022", text: "Beep", flavor: "", artist: "", number: "", power: "", toughness: "", layout: "", multiverseid: "", imageURL: "https://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=571337&type=card", printings: [""], originalText: "", originalType: "", id: "18468b64-37ef-5e4d-b95a-781265b533a2", uuid: "")]
    
    
    @Published var fileteredCardData = [Card]()
    
    //MARK: - CARDS
    private var cardsUrl = "https://api.magicthegathering.io/v1/cards?&set=40K"
    
    
    //MARK: - Fetching
    func fetchCards() async {
        guard let downloadCard: CardsMTG = await WebService().downloadData(fromURL: cardsUrl) else { return }
        cardData = downloadCard.cards
        
        DispatchQueue.main.async { [self] in
            for card in cardData {
                if card.imageURL != nil {
                    let cardString: String = card.imageURL!.replacingOccurrences(of: "http", with: "https") ?? ""
                    fileteredCardData.append(Card(name: card.name, manaCost: card.manaCost, cmc: card.cmc, colors: card.colors, colorIdentity: card.colorIdentity, type: card.type, types: card.types, subtypes: card.subtypes, rarity: card.rarity, setCode: card.setCode, setName: card.setName, text: card.text, flavor: card.flavor, artist: card.artist, number: card.number, power: card.power, toughness: card.toughness, layout: card.layout, multiverseid: card.multiverseid, imageURL: cardString, printings: card.printings, originalText: card.originalText, originalType: card.originalType, id: card.id, uuid: card.uuid))
                    print(cardString)
                } else {
                    //print(card.name)
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
                    let cardString: String = card.imageURL!.replacingOccurrences(of: "http", with: "https") ?? ""
                    fileteredCardData.append(Card(name: card.name, manaCost: card.manaCost, cmc: card.cmc, colors: card.colors, colorIdentity: card.colorIdentity, type: card.type, types: card.types, subtypes: card.subtypes, rarity: card.rarity, setCode: card.setCode, setName: card.setName, text: card.text, flavor: card.flavor, artist: card.artist, number: card.number, power: card.power, toughness: card.toughness, layout: card.layout, multiverseid: card.multiverseid, imageURL: cardString, printings: card.printings, originalText: card.originalText, originalType: card.originalType, id: card.id, uuid: card.uuid))
                    print(cardString)
                } else {
                    print(card.name)
                }
            }
            
            for _ in fileteredCardData {
                //print(image.imageURL!)
                print(fileteredCardData.count)
                print(cardData.count)
            }
        }
    }
    
    //MARK: - Saving
    func addCardToCollection(selectedCollection: String, cardName: String, cardMana: String, cardCMC: Int, cardColors: [String], cardColorIdent: [String], cardType: String, cardTypes: [String], cardSubtypes: [String], cardRarity: String, cardSetCode: String, cardSetName: String, cardText: String, cardFlavor: String, cardArtist: String, cardNumber: String, cardPower: String, cardTough: String, cardLayout: String, cardMulti: String, cardImgUrl: String, cardPrintings: [String], cardOriginTxt: String, cardOriginType: String, cardId: String, cardUUID: String) {
        
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let uniqueID = "\(uid)\(selectedCollection)"
        let uniqueCard = "\(uid)$\(cardUUID)"
        let cardData = [
            "name": cardName,
            "manaCost": cardMana,
            "cmc": cardCMC,
            "colors": cardColors,
            "colorIdentity": cardColorIdent,
            "type": cardType,
            "types": cardTypes,
            "subtypes": cardSubtypes,
            "rarity": cardRarity,
            "setCode": cardSetCode,
            "setName": cardSetName,
            "text": cardText,
            "flavor": cardFlavor,
            "artist": cardArtist,
            "number": cardNumber,
            "power": cardPower,
            "toughness": cardTough,
            "layout": cardLayout,
            "multiverseid": cardMulti,
            "imageUrl": cardImgUrl,
            "printings": cardPrintings,
            "originalText": cardText,
            "originalType": cardOriginType,
            "id": cardId,
            "uuid": cardUUID
        ] as [String : Any]
        FirebaseManager.shared.firestore.collection("Collections").document(uniqueID).collection("Cards").document(uniqueCard).setData(cardData) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }
    }
    
    
    //MARK: - Collections
    @Published var collectionData = [Collection]()
    @Published var subCollectionCards = [Card]()
    @Published var cardsTestSubColl = [Card]()
    
    func fetchCollectionFromDB() {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
        FirebaseManager.shared.firestore.collection("Collections").addSnapshotListener { snapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else {return}
            
            self.collectionData = documents.map { (querrySnapshot) -> Collection in
                let data = querrySnapshot.data()
                let colName = data["name"] as? String ?? ""
                //let cards = data["cards"] as? [Card]
                //let newCollection = Collection(name: name, cards: cards ?? [self.mockCards[0]])
                //print(newCollection)
                
                //self.subCollectionCard(colName: colName)
                self.subCollectionCard(colName: colName)
                let newCollection = Collection(name: colName, cards: self.subCollectionCards)
                print(self.subCollectionCards)
                return newCollection
            }
        }
    }
    
    func subCollectionCard(colName: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return}
        FirebaseManager.shared.firestore.collection("Collections").document("\(uid)\(colName)").collection("Cards").addSnapshotListener { cardsSnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let docs = cardsSnapshot?.documents else { return}
            self.subCollectionCards = docs.map {(querrySnapshotCard) -> Card in
                let cardData = querrySnapshotCard.data()
                
                let name = cardData["name"] as? String ?? ""
                let manaCost = cardData["manaCost"] as? String ?? ""
                let cmc = cardData["cmc"] as? Int ?? 0
                let colors = cardData["colors"] as? [String] ?? [""]
                let colorIdentity = cardData["colorIdentity"] as? [String] ?? [""]
                let type = cardData["type"] as? String ?? ""
                let types = cardData["types"] as? [String] ?? [""]
                let subtypes = cardData["subtypes"] as? [String] ?? [""]
                let rarity = cardData["rarity"] as? String ?? ""
                let setCode = cardData["setCode"] as? String ?? ""
                let setName = cardData["setName"] as? String ?? ""
                let text = cardData["text"] as? String ?? ""
                let flavor = cardData["flavor"] as? String ?? ""
                let artist = cardData["artist"] as? String ?? ""
                let number = cardData["number"] as? String ?? ""
                let power = cardData["power"] as? String ?? ""
                let toughness = cardData["toughness"] as? String ?? ""
                let layout = cardData["layout"] as? String ?? ""
                let multiverseid = cardData["multiverseid"] as? String ?? ""
                let imageURL = cardData["imageUrl"] as? String ?? ""
                let printings = cardData["printings"] as? [String] ?? [""]
                let originalText = cardData["originalText"] as? String ?? ""
                let originalType = cardData["originalType"] as? String ?? ""
                let id = cardData["id"] as? String ?? ""
                let uuid = cardData["uuid"] as? String ?? ""
                
                
                let newCard = Card(name: name, manaCost: manaCost, cmc: cmc, colors: colors, colorIdentity: colorIdentity, type: type, types: types, subtypes: subtypes, rarity: rarity, setCode: setCode, setName: setName, text: text, flavor: flavor, artist: artist, number: number, power: power, toughness: toughness, layout: layout, multiverseid: multiverseid, imageURL: imageURL, printings: printings, originalText: originalText, originalType: originalType, id: id, uuid: uuid)
                //self.subCollectionCards.append(newCard)
                //print("Cards coll: \(self.subCollectionCards)")
                return newCard
            }
            for card in self.subCollectionCards {
                print("UUID: \(card.uuid)" ?? "UUID")
            }
        }
    }
    
    func returnSubCollectionCard(colName: String){
        cardsTestSubColl = []
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.firestore.collection("Collections").document("\(uid)\(colName)").collection("Cards").addSnapshotListener { cardsSnapshot, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let docs = cardsSnapshot?.documents else { return}
            self.subCollectionCards = docs.map {(querrySnapshotCard) -> Card in
                let cardData = querrySnapshotCard.data()
                
                let name = cardData["name"] as? String ?? ""
                let manaCost = cardData["manaCost"] as? String ?? ""
                let cmc = cardData["cmc"] as? Int ?? 0
                let colors = cardData["colors"] as? [String] ?? [""]
                let colorIdentity = cardData["colorIdentity"] as? [String] ?? [""]
                let type = cardData["type"] as? String ?? ""
                let types = cardData["types"] as? [String] ?? [""]
                let subtypes = cardData["subtypes"] as? [String] ?? [""]
                let rarity = cardData["rarity"] as? String ?? ""
                let setCode = cardData["setCode"] as? String ?? ""
                let setName = cardData["setName"] as? String ?? ""
                let text = cardData["text"] as? String ?? ""
                let flavor = cardData["flavor"] as? String ?? ""
                let artist = cardData["artist"] as? String ?? ""
                let number = cardData["number"] as? String ?? ""
                let power = cardData["power"] as? String ?? ""
                let toughness = cardData["toughness"] as? String ?? ""
                let layout = cardData["layout"] as? String ?? ""
                let multiverseid = cardData["multiverseid"] as? String ?? ""
                let imageURL = cardData["imageUrl"] as? String ?? ""
                let printings = cardData["printings"] as? [String] ?? [""]
                let originalText = cardData["originalText"] as? String ?? ""
                let originalType = cardData["originalType"] as? String ?? ""
                let id = cardData["id"] as? String ?? ""
                let uuid = cardData["uuid"] as? String ?? ""
                
                let newCard = Card(name: name, manaCost: manaCost, cmc: cmc, colors: colors, colorIdentity: colorIdentity, type: type, types: types, subtypes: subtypes, rarity: rarity, setCode: setCode, setName: setName, text: text, flavor: flavor, artist: artist, number: number, power: power, toughness: toughness, layout: layout, multiverseid: multiverseid, imageURL: imageURL, printings: printings, originalText: originalText, originalType: originalType, id: id, uuid: uuid)
                //self.subCollectionCards.append(newCard)
                //print("Cards coll: \(self.subCollectionCards)")
                self.cardsTestSubColl.append(newCard)
                return newCard
            }
        }
    }
    //MARK: - Deleting
    func deleteFromCollection(collectionName: String, cardUUID: String) {
        guard let uid = FirebaseManager.shared.auth.currentUser?.uid else {return}
        let uniqueID = "\(uid)\(collectionName)"
        let uniqueCard = "\(uid)$\(cardUUID)"
        
        FirebaseManager.shared.firestore.collection("Collections").document(uniqueID).collection("Cards").document(uniqueCard).delete()
        print("Deleted - \(uniqueCard)")
    }
}

