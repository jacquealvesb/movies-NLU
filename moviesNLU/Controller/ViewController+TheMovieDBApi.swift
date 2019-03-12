//
//  ViewController+TheMovieDBApi.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 11/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import Foundation

extension ViewController {
    func getMovieID(of name:String, completionHandler: @escaping (_ id: Int?) -> ()) {
        let movieURL = name.movieURL()
        
        let task = URLSession.shared.dataTask(with: movieURL!) { (data, response, error) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let results = json["results"] as? [[String:Any]], results.count > 0 {
                            if let id = results.first!["id"] as? Int {
                                completionHandler(id)
                            } else {
                                completionHandler(nil)
                            }
                            
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
    
    //func getMovieReviews(withID id: Int, completionHandler: (_ ))

}
