//
//  NavBarExtension.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 16.11.23.
//

import SwiftUI

extension View {
    
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor]
        
        return self
    }
}
