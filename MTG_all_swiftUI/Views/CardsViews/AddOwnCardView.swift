//
//  AddOwnCardView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 21.03.24.
//

import SwiftUI
import PhotosUI

@available(iOS 17.0, *)
struct AddOwnCardView: View {
    @State private var photoItem: PhotosPickerItem?
    @State private var selectedPhoto: Image?
    @State private var cardName = ""
    @State private var cardSet = ""
    @State private var cardManaCost = ""
    @State private var cardDescription = ""

    
    var body: some View {
        ZStack {
            Text("Select photo")
            
            VStack {
                PhotosPicker(selection: $photoItem) {
                    if selectedPhoto == nil {
                        Image("card_placeholder")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    } else {
                        selectedPhoto?
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                    }
                }
                .onChange(of: photoItem) {
                    Task {
                        if let loaded = try? await photoItem?.loadTransferable(type: Image.self) {
                            selectedPhoto = loaded
                        } else {
                            selectedPhoto = Image("card_placeholder")
                        }
                    }
                }
            }
            
            VStack {
                
            }
        }
        .ignoresSafeArea()
        .navigationTitle("Create card")
    }
}

#Preview {
    if #available(iOS 17.0, *) {
        AddOwnCardView()
    } else {
        EmptyView()
    }
}
