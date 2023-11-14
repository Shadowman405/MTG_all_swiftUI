//
//  HpCounterView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI

struct HpCounterView: View {
    var body: some View {
        HStack {
            Text("HP Counter")
            Image("B")
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    HpCounterView()
}
