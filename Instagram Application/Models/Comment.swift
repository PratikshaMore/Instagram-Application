//
//  Comment.swift
//  Instagram Application
//
//  Created by Pratiksha Pradip More on 8/2/18.
//  Copyright © 2018 Pratiksha Pradip More. All rights reserved.
//

import Foundation

struct Comment {
    
    let user: User
    
    let text: String
    let uid: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
