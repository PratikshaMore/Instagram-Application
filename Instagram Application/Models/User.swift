//
//  User.swift
//  Instagram Application
//
//  Created by Pratiksha Pradip More on 7/31/18.
//  Copyright © 2018 Pratiksha Pradip More. All rights reserved.
//

import Foundation

struct User {
    
    let uid: String
    let username: String
    let profileImageUrl: String
    
    init(uid: String,dictionary: [String: Any]) {
        self.uid = uid
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
    }
}
