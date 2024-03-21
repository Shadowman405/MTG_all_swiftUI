//
//  AddOwnCardView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 21.03.24.
//

import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
struct AddOwnCardView: View {
    @State private var photoItem: PhotosPickerItem?
    @State private var selectedPhoto: Image?
    
    var body: some View {
        ZStack {
            Text("Select photo")
            
            VStack {
                PhotosPicker(selection: $photoItem, matching: .images) {
                    
                    selectedPhoto?
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 400)
                }
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Add your own card")
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        AddOwnCardView()
    } else {
        // Fallback on earlier versions
    }
}
