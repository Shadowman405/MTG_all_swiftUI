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
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {throw NetworkError.failedToDecodeResponse}
            
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
            print("failure")
        }
        
        return nil
    }
}


