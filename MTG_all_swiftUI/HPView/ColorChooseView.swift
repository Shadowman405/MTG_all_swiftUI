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
    let playerHP = [20, 30, 40, 50]
    
    @Binding var showView: Bool
    @Binding var playerOneColor: String
    @Binding var playerTwoColor: String
    @Binding var startPlayerHP: Int
    @Binding var playerOneHP: Int
    @Binding var playerTwoHP: Int

    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("First player color - ")
                            .font(.system(size: 20))
                        .foregroundColor(.orange)
                        .padding()
                        
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
                                        .frame(width: 110, height: 110)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                
                Spacer() 
                
                VStack {
                    HStack {
                        Text("Second player color - ")
                            .font(.system(size: 20))
                        .foregroundColor(.orange)
                        .padding()
                        
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
                                        .frame(width: 110, height: 110)
                                        .padding()
                                }
                            }
                        }
                    }
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Text("Choose players start HP")
                            .font(.system(size: 20))
                            .foregroundColor(.orange)
                    }
                    
                    ScrollView(.horizontal) {
                        LazyHGrid(rows: rows) {
                            ForEach(playerHP, id: \.self) { hp in
                                Button{
                                  startPlayerHP = hp
                                    playerOneHP = hp
                                    playerTwoHP = hp
                                } label: {
                                    Text(String(hp))
                                        .frame(width: 120, height: 120)
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
    ColorChooseView(showView: .constant(false), playerOneColor: .constant("{W}"), playerTwoColor: .constant("{G}"), startPlayerHP: .constant(20), playerOneHP: .constant(20), playerTwoHP: .constant(20))
}
