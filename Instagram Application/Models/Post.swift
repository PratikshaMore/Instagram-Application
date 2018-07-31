//
//  Post.swift
//  Instagram Application
//
//  Created by Pratiksha Pradip More on 7/30/18.
//  Copyright © 2018 Pratiksha Pradip More. All rights reserved.
//

import Foundation

struct Post {
    let user: User
    let imageUrl: String
    let caption: String
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
    }
}
    
