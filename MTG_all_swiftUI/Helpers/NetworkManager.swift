//
//  NetworkManager.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import Foundation
import Foundation
import UIKit

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
    @Published var fileteredCardData = [Card]()
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
            
            for image in fileteredCardData {
                //print(image.imageURL!)
                print(fileteredCardData.count)
                print(cardData.count)
            }
        }
    }
    
    func addManaImages(someString: String?) -> NSMutableAttributedString {
        guard let manaCost = someString else {return NSMutableAttributedString()}
        let imagesDict: [String:String] = ["{W}":"W", "{R}":"R","{B}":"B","{G}":"G","{U}":"U", "{1}":"One", "{2}":"Two", "{3}":"Three",
                                           "{4}":"Four", "{5}":"Five", "{6}":"Six", "{7}":"Seven", "{8}":"Eight", "{9}":"Nine", "{0}":"Zero",
                                           "{T}":"T_2nd", "{G/W}":"GW", "{G/U}":"GU", "{W/B}":"WB", "{W/U}":"WU", "{X}":"X", "{U/B}":"UB", "{B/R}":"BR", "{R/G}":"RG", "{U/R}":"UR", "{B/G}":"BG", "{R/W}":"RW",
                                           "{2/W}":"2W", "{2/U}":"2U", "{2/B}":"2B", "{2/R}":"2R"
        ]
        let fullString = NSMutableAttributedString(string: manaCost)
        
        for (imageTag, imageName) in imagesDict {
            let pattern = NSRegularExpression.escapedPattern(for: imageTag)
            let regex = try? NSRegularExpression(pattern: pattern,
                                                 options: [])
            if let matches = regex?.matches(in: fullString.string, range: NSRange(location: 0, length: fullString.string.utf16.count)) {
                for aMtach in matches.reversed() {
                    let attachment = NSTextAttachment()
                    attachment.image = UIImage(named: imageName)
                    attachment.bounds = CGRectMake(0, 0, 24, 24)
                    let replacement = NSAttributedString(attachment: attachment)
                    fullString.replaceCharacters(in: aMtach.range, with: replacement)
                }
            }
        }
        
        return fullString
        
    }
}

