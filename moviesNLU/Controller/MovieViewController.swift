//
//  MovieViewController.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 16/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit
import NaturalLanguageUnderstanding
import SafariServices

var configuration: Configuration?

class MovieViewController: UIViewController {
    
    // Objects
    let posterImageView: UIImageView = UIImageView(frame: CGRect.zero)
    let nameLabel: UILabel = UILabel(frame: CGRect.zero)
    let reviewsAnalysisLabel: UILabel = UILabel(frame: CGRect.zero)
    let readReviewsButton: UIButton = UIButton(frame: CGRect.zero)
    let emotionsTableView: UITableView = UITableView(frame: CGRect.zero)
    let closeButton: UIButton = UIButton(frame: CGRect.zero)
    
    // Variables
    var emotions: [Emotion] = [Emotion(name: "joy", score: 0),
                               Emotion(name: "anger", score: 0),
                               Emotion(name: "disgust", score: 0),
                               Emotion(name: "sadness", score: 0),
                               Emotion(name: "fear", score: 0)]
    var joy: Double!
    var anger: Double!
    var disgust: Double!
    var sadness: Double!
    var fear: Double!
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "darkGray")
        
        self.setupNameLabel()
        self.setupReviewsAnalysisLabel()
        self.setupReadReviewsButton()
        self.setupEmotionsTableView()
        self.setupCloseButton()
    }
    
    // MARK: - Layout
    func setupNameLabel() {
        self.nameLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        self.nameLabel.textColor = .white
        self.nameLabel.textAlignment = .center
    }
    
    func setupReviewsAnalysisLabel() {
        self.reviewsAnalysisLabel.text = "reviews analysis:"
        self.reviewsAnalysisLabel.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        self.reviewsAnalysisLabel.textColor = .white
        self.reviewsAnalysisLabel.textAlignment = .left
    }
    
    func setupReadReviewsButton() {
        let attributes : [NSAttributedString.Key: Any] = [.font : UIFont.systemFont(ofSize: 18, weight: .light),
                                                          .foregroundColor : UIColor(named: "pastelOrange") ?? .white,
                                                          .underlineStyle : NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "read reviews",
                                                        attributes: attributes)
        self.readReviewsButton.setAttributedTitle(attributeString, for: .normal)
        self.readReviewsButton.addTarget(self, action: #selector(openReviewsURL), for: .touchUpInside)
    }
    
    func setupCloseButton() {
        self.closeButton.setTitle("close", for: .normal)
        self.closeButton.setTitleColor(.systemBlue, for: .normal)
        self.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Emotions Scores
    func setupEmotionsTableView() {
        self.emotionsTableView.backgroundColor = .clear
        self.emotionsTableView.separatorStyle = .none
        self.emotionsTableView.allowsSelection = false
        
        self.emotionsTableView.register(EmotionsTableViewCell.self, forCellReuseIdentifier: EmotionsTableViewCell.identifier)
        
        self.emotionsTableView.dataSource = self
        self.emotionsTableView.delegate = self
    }
    
    func emotionIndex(withName name: String) -> Int? {
        return emotions.firstIndex { emotion -> Bool in
            return emotion.name == name
        }
    }
    
    func setScore(_ score: Double?, toEmotion emotion: String) {
        if let index = emotionIndex(withName: emotion), let score = score {
            emotions[index].score = score
        }
    }
    
    func setBars(_ emotionScores: [EmotionScores]) {
        if let emotionScoreAverage = NLUFacade.shared.emotionAverage(emotionScores) {
            self.setScore(emotionScoreAverage.joy, toEmotion: "joy")
            self.setScore(emotionScoreAverage.anger, toEmotion: "anger")
            self.setScore(emotionScoreAverage.disgust, toEmotion: "disgust")
            self.setScore(emotionScoreAverage.sadness, toEmotion: "sadness")
            self.setScore(emotionScoreAverage.fear, toEmotion: "fear")
            
            self.emotionsTableView.reloadData()
        }
    }
    // MARK: - Movie Reviews Analysis
    func getConfiguration(completion: @escaping (_ success: Bool, _ error: RequestErrors?) -> Void) {
        TheMovieDBFacade.shared.getConfiguration { conf in
            if let conf = conf {
                configuration = conf
                completion(true, nil)
            } else {
                completion(false, .none)
            }
        }
    }
    
    func setup(withMovieName name: String, completion: @escaping (_ success: Bool, _ error: RequestErrors?) -> Void) {
        TheMovieDBFacade.shared.getMovie(withName: name) { movie in
            if let movie = movie {
                
                self.url = "https://www.themoviedb.org/movie/\(movie.id)/reviews"
                
                DispatchQueue.main.async {
                    self.nameLabel.text = movie.title
                }
                
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
            let sf = SFSafariViewController(url: url)
            
            sf.modalPresentationStyle = .formSheet
            self.present(sf, animated: true, completion: nil)
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
}
