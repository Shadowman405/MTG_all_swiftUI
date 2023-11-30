//
//  ColorChooseView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 30.11.23.
//

import SwiftUI

struct ColorChooseView: View {
    @Binding var showView: Bool
    
    var body: some View {
        ZStack {
            Text("Choose Color")
            Button {
                showView.toggle()
            } label: {
                Text("Cancel")
            }
        }
        .navigationTitle("Color Choose")
        .toolbar {
            Button {
                showView.toggle()
            } label: {
                Text("Cancel")
            }
        }
    }
}

#Preview {
    ColorChooseView(showView: .constant(false))
}
