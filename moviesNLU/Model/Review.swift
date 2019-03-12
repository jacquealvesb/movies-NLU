//
//  Review.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 12/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation

class Review {
    var author: String
    var content: String
    var id: String
    var url: String
    
    init(withAuthor author: String, content: String, id: String, andURL url: String) {
        self.author = author
        self.content = content
        self.id = id
        self.url = url
    }
    
    init(withDictionary dict: [String:Any]) {
        self.author = dict["author"] as? String ?? ""
        self.content = dict["content"] as? String ?? ""
        self.id = dict["id"] as? String ?? ""
        self.url = dict["url"] as? String ?? ""
    }
}
