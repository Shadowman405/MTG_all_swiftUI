//
//  ContentView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            ZStack {
                Image("logo")
                    //.imageScale(.small)
                    //.foregroundStyle(.tint)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                Text("Hello, world!")
            }
        }
    }
}

#Preview {
    ContentView()
}
