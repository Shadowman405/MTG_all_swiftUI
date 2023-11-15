//
//  MTG_all_swiftUIApp.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI
import Firebase

@main
struct MTG_all_swiftUIApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            LoginView()
        }
    }
}
