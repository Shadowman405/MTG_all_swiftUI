//
//  Set.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 4.12.23.
//

import Foundation

struct SetsMTG: Codable {
    let sets: [Set]
}

// MARK: - Set
struct Set: Codable, Hashable {
    let code, name, type: String?
    let booster: [Booster]?
    let releaseDate, block: String?
    let onlineOnly: Bool?
}

enum Booster: String, Codable {
    case common = "common"
    case rare = "rare"
    case uncommon = "uncommon"
}
