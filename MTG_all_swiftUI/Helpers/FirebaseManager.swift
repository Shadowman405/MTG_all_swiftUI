//
//  FirebaseManager.swift
//  MTG_all_swiftUI
//
//  Created by Maxim Mitin on 15.11.23.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FirebaseManager: NSObject {
    let auth: Auth
    let firestore: Firestore
    let storage: Storage
    
    static let shared = FirebaseManager()
    
    override init() {
        
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.storage = Storage.storage()
        
        super.init()
    }
}
