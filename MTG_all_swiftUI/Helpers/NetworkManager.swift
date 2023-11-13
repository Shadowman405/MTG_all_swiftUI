//
//  NetworkManager.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import Foundation

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
    @Published var cardData = [Card]()
    private var cardsUrl = "https://api.magicthegathering.io/v1/cards?&set=40K"
    
    func fetchCards() async {
        guard let downloadCard: [Card] = await WebService().downloadData(fromURL: cardsUrl) else { return }
        cardData = downloadCard
    }
}

