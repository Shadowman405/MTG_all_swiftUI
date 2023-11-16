//
//  ContentView.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 12.11.23.
//

import SwiftUI
import Firebase

struct ContentView: View {
    //@EnvironmentObject var logedInUser: isLogedInUser
    @Binding var logedIn : Bool
    
    var body: some View {
        if logedIn {
            content
        } else {
            LoginView()
        }
    }
    
    var content: some View {
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
            .navigationTitle("Main menu")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        signOut()
                    } label: {
                        Text("Signout")
                            .foregroundStyle(.orange)
                        Label("Signout", systemImage: "person.crop.circle.badge.xmark")
                            .foregroundColor(.orange)
                    }

                }
            }
        }
    }
    
    func signOut() {
        print("Status - \(logedIn)")
        do {
            try Auth.auth().signOut()
            logedIn.toggle()
            print("signed out")
        } catch {
            print("Error")
        }
    }
}

#Preview {
    ContentView(logedIn: .constant(true))
}
