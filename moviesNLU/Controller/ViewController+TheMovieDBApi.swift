//
//  ViewController+TheMovieDBApi.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 11/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation

extension ViewController {
    func getMovie(withName name:String, completionHandler: @escaping (_ id: Movie?) -> ()) {
        let nameFormatted = name.replacingOccurrences(of: " ", with: "+")
        let movieURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(nameFormatted)")
        
        let task = URLSession.shared.dataTask(with: movieURL!) { (data, response, error) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let results = json["results"] as? [[String:Any]], results.count > 0 {
                            let movie = Movie(withDictionary: results.first!)
                            
                            completionHandler(movie)
                            
                        } else {
                            completionHandler(nil)
                        }
                    } else {
                        completionHandler(nil)
                    }
                    
                } catch {
                    print(error)
                    completionHandler(nil)
                }
            }
        }
        
        task.resume()
    }
    
    func getMovieReviews(withID id: Int, completionHandler: @escaping (_ reviews: [Review]) -> ()) {
        let movieReviewsURL = URL(string: "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=\(apiKey)&language=en-US")
        
        let task = URLSession.shared.dataTask(with: movieReviewsURL!) { (data, response, error) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let results = json["results"] as? [[String:Any]], results.count > 0 {
                            var reviews = [Review]()
                            
                            for review in results {
                                reviews.append(Review(withDictionary: review))
                            }
                            
                            completionHandler(reviews)
                            
                        } else {
                            completionHandler([])
                        }
                    } else {
                        completionHandler([])
                    }
                    
                } catch {
                    print(error)
                    completionHandler([])
                }
            }
        }
        
        task.resume()
    }

}
