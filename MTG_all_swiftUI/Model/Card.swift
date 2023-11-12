//
//  Card.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import Foundation
import SwiftUI

struct Card: Codable, Identifiable {
    let name, manaCost: String
    let cmc: Int
    let colors, colorIdentity: [String]
    let type: String
    let types, subtypes: [String]
    let rarity, setCode, setName, text: String
    let flavor, artist, number, power: String
    let toughness, layout, multiverseid: String
    let imageURL: String
    let printings: [String]
    let originalText, originalType: String
    let legalities: [LegalityElement]
    let id: String

    enum CodingKeys: String, CodingKey {
        case name, manaCost, cmc, colors, colorIdentity, type, types, subtypes, rarity
        case setCode = "set"
        case setName, text, flavor, artist, number, power, toughness, layout, multiverseid
        case imageURL = "imageUrl"
        case printings, originalText, originalType, legalities, id
    }
}

// MARK: - LegalityElement
struct LegalityElement: Codable {
    let format: String
    let legality: LegalityEnum
}

enum LegalityEnum: String, Codable {
    case legal = "Legal"
    case restricted = "Restricted"
}
