//
//  ColorChooseView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 30.11.23.
//

import SwiftUI

struct ColorChooseView: View {
    @Binding var showView: Bool
    @Binding var playerOneColor: String
    @Binding var playerTwoColor: String
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Choose Color")
            }
            .navigationTitle("Color Choose")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showView.toggle()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.orange)
                    }
                }
        }
        }
    }
}

#Preview {
    ColorChooseView(showView: .constant(false), playerOneColor: .constant("{W}"), playerTwoColor: .constant("{G}"))
}
