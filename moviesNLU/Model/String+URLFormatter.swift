//
//  String+URLFormatter.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 11/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation

extension String {
    func movieURL() -> URL? {
        let formatted = self.replacingOccurrences(of: " ", with: "+")
        return URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(formatted)")
    }
}
