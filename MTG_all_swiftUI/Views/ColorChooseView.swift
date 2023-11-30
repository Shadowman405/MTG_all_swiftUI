//
//  ColorChooseView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 30.11.23.
//

import SwiftUI

struct ColorChooseView: View {
    let rows = [GridItem(.fixed(100))]
    let colors = ["{W}","{G}","{U}","{R}","{B}"]
    
    @Binding var showView: Bool
    @Binding var playerOneColor: String
    @Binding var playerTwoColor: String
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("First player color - ")
                            .font(.system(size: 20))
                        .foregroundColor(.orange)
                        
                        Image(playerOneColor)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows) {
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    playerOneColor = color
                                } label: {
                                    Image(color)
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Text("Second player color - ")
                            .font(.system(size: 20))
                        .foregroundColor(.orange)
                        
                        Image(playerTwoColor)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows) {
                            ForEach(colors, id: \.self) { color in
                                Button {
                                    playerTwoColor = color
                                } label: {
                                    Image(color)
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .padding()
                                }
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
                        Text("Save")
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
