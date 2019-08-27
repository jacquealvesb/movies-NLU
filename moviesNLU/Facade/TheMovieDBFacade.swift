//
//  TheMovieDBFacade.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 26/08/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation

class TheMovieDBFacade {
    // MARK: - Variables
    public static let shared = TheMovieDBFacade()
    let apiKey = TheMovieDBApiKey
    
    //MARK: - Functions
    
    /// Requests an url and returns a dictionary representing the json returned.
    ///
    /// - Parameters:
    ///   - url: URL to request
    ///   - completionHandler: Handler of the returning json object
    func request(url: String, completionHandler: @escaping (_ dict: [String: Any]?) -> ()) {
        guard let requestURL = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            if let data = data {
                do {
                    if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        completionHandler(dict)
                       
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
    
    
    /// Gets the system wide configuration information returning the data relevant to building image URLs as well as the change key map.
    ///
    /// - Parameters:
    ///   - completionHandler: Handler of the configuration information returned
    func getConfiguration(completionHandler: @escaping (_ configuration: Configuration?) -> ()) {
        let configurationURL = "https://api.themoviedb.org/3/configuration?api_key=\(apiKey)"
        
        self.request(url: configurationURL) { data in
            if let data = data {
                let configuration = Configuration(withDictionary: data)
                
                completionHandler(configuration)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    
    /// Returns the Movie object of the requested movie name.
    ///
    /// - Parameters:
    ///   - name: Name of the movie
    ///   - completionHandler: Handler of the movie object returned
    func getMovie(withName name:String, completionHandler: @escaping (_ movie: Movie?) -> ()) {
        let nameFormatted = name.replacingOccurrences(of: " ", with: "+")
        let movieURL = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(nameFormatted)"
        
        self.request(url: movieURL) { data in
            if let data = data {
                // Checks if any movie was found with the name and returns the first one
                if let results = data["results"] as? [[String:Any]], results.count > 0 {
                    let movie = Movie(withDictionary: results.first!)
                    
                    completionHandler(movie)
                    
                }
            } else {
                completionHandler(nil)
            }
        }
    }
    
    
    /// Returns an array with all reviews of a movie
    ///
    /// - Parameters:
    ///   - id: ID of the movie to find the reviews
    ///   - completionHandler: Handler of the reviews returned
    func getReviews(of movie: Movie, completionHandler: @escaping (_ reviews: [Review]) -> ()) {
        let movieReviewsURL = "https://api.themoviedb.org/3/movie/\(movie.id)/reviews?api_key=\(apiKey)&language=en-US"
        
        self.request(url: movieReviewsURL) { data in
            if let data = data {
                var reviews = [Review]() //Array of found reviews

                // Gets the reviews dictionary
                if let results = data["results"] as? [[String:Any]] {
                    
                    // Creates a Review object for each review returned
                    for review in results {
                        reviews.append(Review(withDictionary: review))
                    }
                }
                
                completionHandler(reviews)
            }
        }
    }
}
