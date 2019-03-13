//
//  Images.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 13/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation

class Images {
    var baseURL: String
    var secureBaseURL: String
    var backdropSizes: [String]
    var logoSizes: [String]
    var posterSizes: [String]
    var profileSizes: [String]
    var stillSizes: [String]
    
    init(withDictionary dict: [String:Any]) {
        self.baseURL = dict["base_url"] as? String ?? ""
        self.secureBaseURL = dict["secure_base_url"] as? String ?? ""
        self.backdropSizes = dict["backdrop_sizes"] as? [String] ?? []
        self.logoSizes = dict["logo_sizes"] as? [String] ?? []
        self.posterSizes = dict["poster_sizes"] as? [String] ?? []
        self.profileSizes = dict["profile_sizes"] as? [String] ?? []
        self.stillSizes = dict["still_sizes"] as? [String] ?? []
    }
}
