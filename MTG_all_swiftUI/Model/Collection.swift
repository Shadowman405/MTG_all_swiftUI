//
//  Collection.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import Foundation

struct Collection: Codable, Identifiable {
    var id = UUID()
    var name = ""
    var cards: [Card]
}
