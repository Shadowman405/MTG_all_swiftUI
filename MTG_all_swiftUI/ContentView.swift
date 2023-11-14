//
//  ContentView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                ZStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                
                
                NavigationLink {
                    CardsView()
                } label: {
                    Text("Cards")
                        .font(.system(size: 30))
                        .foregroundStyle(.orange)
                       // .fontWeight(.bold)
                }

            }
        }
    }
}

#Preview {
    ContentView()
}
