//
//  FractalFriend.swift
//  FractalFriend
//
//  Created by Freddy Hernandez on 6/7/17.
//  Copyright © 2017 Freddy Hernandez. All rights reserved.
//

import Foundation
import FirebaseDatabase
// fractalFriends
struct FractalFriend {
    let key: String!
    let url: String!
    
    let itemRef: DatabaseReference?
    
    init(key: String, url: String) {
        self.key = key
        self.url = url
        self.itemRef = nil
    }
    
    init(snapshot: DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let snapshotInfo = snapshot.value as? NSDictionary {
            if let imageURL = snapshotInfo["url"] as? String {
                url = imageURL
            } else {
                url = ""
            }
        } else {
            url = ""
        }
    }
}
