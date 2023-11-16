//
//  Route.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 15.11.23.
//

import Foundation

enum Route: Hashable {
    case ContentView
    case content
}

class isLogedInUser: ObservableObject {
    @Published var logedIn = false
}
