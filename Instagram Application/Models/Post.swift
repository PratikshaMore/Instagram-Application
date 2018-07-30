//
//  Post.swift
//  Instagram Application
//
//  Created by Pratiksha Pradip More on 7/30/18.
//  Copyright © 2018 Pratiksha Pradip More. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl : String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
