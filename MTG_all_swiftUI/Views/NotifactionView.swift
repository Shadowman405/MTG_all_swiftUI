//
//  NotifactionView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 21.12.23.
//

import SwiftUI

struct NotifactionView: View {
    var cardName = ""
    var collectionName = ""
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(height: 40)
            
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.orange)
        }
        .padding()
    }
}

#Preview {
    NotifactionView()
}
