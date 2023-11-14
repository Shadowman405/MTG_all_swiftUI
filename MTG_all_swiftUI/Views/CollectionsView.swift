//
//  CollectionsView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI

struct CollectionsView: View {
    var body: some View {
        HStack{
            Text("Collections")
            Image("W")
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}

#Preview {
    CollectionsView()
}
