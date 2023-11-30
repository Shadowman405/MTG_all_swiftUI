//
//  ColorChooseView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 30.11.23.
//

import SwiftUI

struct ColorChooseView: View {
    let rows = [GridItem(.fixed(100))]
    let colors = ["{W}","{G}","{U}", "{R}"]
    
    @Binding var showView: Bool
    @Binding var playerOneColor: String
    @Binding var playerTwoColor: String
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Choose Color For First Player")
                        .font(.system(size: 20))
                        .foregroundColor(.orange)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows) {
                            ForEach(colors, id: \.self) { color in
                                Image(color)
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .padding()
                            }
                        }
                    }
                }
                
                VStack {
                    Text("Choose Color For Second Player")
                        .font(.system(size: 20))
                        .foregroundColor(.orange)
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows) {
                            ForEach(colors, id: \.self) { color in
                                Image(color)
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .padding()
                            }
                        }
                    }
                }
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
