//
//  ContentView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI

struct ContentView: View {
    //@EnvironmentObject var logedInUser: isLogedInUser
    @State var isUserLoggedIn : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                ZStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                
                
                VStack {
                    NavigationLink {
                        CardsView()
                    } label: {
                        Text("Cards")
                            .font(.system(size: 30))
                            .foregroundStyle(.orange)
                    }
                    
                    NavigationLink {
                        CollectionsView()
                    } label: {
                        Text("Collections")
                            .font(.system(size: 30))
                            .foregroundStyle(.orange)
                    }
                    .padding()
                    
                    NavigationLink {
                        HpCounterView()
                    } label: {
                        Text("HP Counter")
                            .font(.system(size: 30))
                            .foregroundStyle(.orange)
                    }
                }
            }
            .toolbar {
                Button("Singout") {
                    print("signout")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
