//
//  Configuration.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 13/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation

class Configuration {
    var images: Images?
    var changeKeys: [String]
    
    init(withDictionary dict: [String:Any]) {
        if let images = dict["images"] as? [String:Any] {
            self.images = Images(withDictionary: images)
        } else {
            self.images = nil
        }
        
        changeKeys = dict["change_keys"] as? [String] ?? []
    }
}
