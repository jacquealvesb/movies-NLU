//
//  MovieViewController.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 16/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit
import NaturalLanguageUnderstanding

class MovieViewController: UIViewController {
    
    // Objects
    let posterImageView: UIImageView = UIImageView(frame: CGRect.zero)
    let nameLabel: UILabel = UILabel(frame: CGRect.zero)
    
    // Variables
    var configuration: Configuration?
    
    var joy: Double!
    var anger: Double!
    var disgust: Double!
    var sadness: Double!
    var fear: Double!
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TheMovieDBFacade.shared.getConfiguration { configuration in
            if let configuration = configuration {
                self.configuration = configuration
            }
        }
    }
    
    func setup(withMovieName name: String, completion: @escaping (_ success: Bool, _ error: RequestErrors?) -> Void) {
        TheMovieDBFacade.shared.getMovie(withName: name) { movie in
            if let movie = movie {
                
                self.url = "https://www.themoviedb.org/movie/\(movie.id)/reviews"
                self.nameLabel.text = movie.title
                
                self.downloadImage(withPath: movie.posterPath, completionHandler: { (image) in
                    DispatchQueue.main.async {
                        self.posterImageView.image = image
                    }
                })
                
                //Get reviews
                TheMovieDBFacade.shared.getReviews(of: movie) { reviews in
                    self.analyze(reviews: reviews) { (success, error) in
                        completion(success, error)
                    }
                }
            } else {
                completion(false, .movieNotFound)
            }
        }
    }
    
    func downloadImage(withPath path: String, completionHandler: @escaping (_ image: UIImage?) -> ()) {
        if let baseURL = configuration?.images?.secureBaseURL, let posterSize = configuration?.images?.posterSizes.last {
            let imageURL = "\(baseURL)\(posterSize)\(path)"
            print(imageURL)
            
            if let imageURL = URL(string: imageURL) {
                let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                    if let data = data {
                        completionHandler(UIImage(data: data))
                    } else {
                        print(error)
                        completionHandler(nil)
                    }
                }
                
                task.resume()
            } else {
                completionHandler(nil)
            }
            
        } else {
            completionHandler(nil)
        }
        
    }
    
    @objc func openReviewsURL() {
        if let url = URL(string: self.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    func analyze(reviews: [Review], completion: @escaping (_ success: Bool, _ error: RequestErrors?) -> Void) {
        if(reviews.count > 0) {
            let dispathGroup = DispatchGroup()
            var emotionScores = [EmotionScores]()
            
            for review in reviews {
                dispathGroup.enter()
                //Analyzes comment
                NLUFacade.shared.analyze(text: review.content, completionHandler: { (result) in
                    if let result = result {
                        if let emotionScore = NLUFacade.shared.emotionScores(of: result) {
                            emotionScores.append(emotionScore)
                        }
                    }
                    dispathGroup.leave()
                })
            }
            
            dispathGroup.notify(queue: DispatchQueue.main, execute: {
                self.setBars(emotionScores)
                completion(true, nil)
            })
            
        } else {
            completion(false, .noReviews)
        }
    }
    
    func setBars(_ emotionScores: [EmotionScores]) {
        if let emotionScoreAverage = NLUFacade.shared.emotionAverage(emotionScores) {
            self.joy = emotionScoreAverage.joy
            self.anger = emotionScoreAverage.anger
            self.disgust = emotionScoreAverage.disgust
            self.sadness = emotionScoreAverage.sadness
            self.fear = emotionScoreAverage.fear
        }
        
    }
}
