//
//  CollectionsView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 14.11.23.
//

import SwiftUI

struct CollectionsView: View {
    var collections: [Collection] = []
    
    var body: some View {
//        HStack{
//            Text("Collections")
//            Image("W")
//                .resizable()
//                .frame(width: 40, height: 40)
//        }
//        
        List(collections) { collection in
            Text(collection.name)
        }
    }
}

#Preview {
    CollectionsView()
}
