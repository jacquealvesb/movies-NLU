//
//  Movie.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 13/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class Movie {
    var posterPath: String
    var poster: UIImage?
    var adult: Bool
    var overview: String
    var releaseDate: Date?
    var genreIDs: [Int]
    var id: Int
    var language: String
    var originalTitle: String
    var title: String
    var backdropPath: String
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var voteAvarage: Double
    
    init(withDictionary dict: [String:Any]) {
        self.posterPath = dict["poster_path"] as? String ?? ""
        self.adult = dict["adult"] as? Bool ?? false
        self.overview = dict["overview"] as? String ?? ""
        
        if let releaseDateString = dict["release_date"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            self.releaseDate = dateFormatter.date(from: releaseDateString)
        } else {
            self.releaseDate = nil
        }
        
        self.genreIDs = dict["genre_ids"] as? [Int] ?? []
        self.id = dict["id"] as? Int ?? -1
        self.language = dict["language"] as? String ?? "en"
        self.originalTitle = dict["original_title"] as? String ?? ""
        self.title = dict["title"] as? String ?? ""
        self.backdropPath = dict["backdrop_path"] as? String ?? ""
        self.popularity = dict["popularity"] as? Double ?? 0.0
        self.voteCount = dict["vote_count"] as? Int ?? 0
        self.video = dict["video"] as? Bool ?? false
        self.voteAvarage = dict["vote_average"] as? Double ?? 0.0
    }
    
    func setPoster(baseURL: String, fileSize: String) {
        let posterURL = "\(baseURL)/\(fileSize)/\(self.posterPath)"
        
        if let posterURL = URL(string: posterURL) {
            URLSession.shared.dataTask(with: posterURL) { (data, response, error) in
                if let data = data {
                    self.poster = UIImage(data: data)
                }
            }
        }
    }
}
