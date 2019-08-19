//
//  ViewController.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 11/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit
import NaturalLanguageUnderstanding

class ViewController: UIViewController {
    let apiKey = TheMovieDBApiKey
    var configuration: Configuration?

    @IBOutlet weak var movieTextField: UITextField!
    @IBOutlet weak var analysisCard: AnalysisCardView!
    
    var spinnerView: UIView?
    var movieID:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.analysisCard.transform = CGAffineTransform(translationX: 0, y: self.analysisCard.frame.size.height)
        self.analysisCard.closeButton.addTarget(self, action: #selector(hideCard), for: .touchUpInside)
        self.analysisCard.readReviewsButton.addTarget(self, action: #selector(self.openReviewsURL), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissViewOrKeyboard))
        view.addGestureRecognizer(tap)
        
        self.movieTextField.delegate = self
        
        self.getConfiguration { (configuration) in
            if let configuration = configuration {
                self.configuration = configuration
            }
        }
        
    }
    
    func analyze(movieNamed name: String) {
        if(name.trimmingCharacters(in: .whitespacesAndNewlines) != "") { //Checking if name isnt empty
            //Find movie
            self.getMovie(withName: name) { (movie) in
                if let movie = movie {
                    //Setting card information
                    DispatchQueue.main.async {
                        self.analysisCard.nameLabel.text = movie.title;
                        self.movieID = movie.id
                    }
                   
                    self.downloadImage(withPath: movie.posterPath, completionHandler: { (image) in
                        DispatchQueue.main.async {
                            self.analysisCard.posterImageView.image = image
                        }
                    })
                    
                    //Get reviews
                    self.getMovieReviews(withID: movie.id, completionHandler: { (reviews) in
                        
                        if(reviews.count > 0) {
                            let dispathGroup = DispatchGroup()
                            var emotionScores = [EmotionScores]()
                            
                            for review in reviews {
                                dispathGroup.enter()
                                //Analyzes comment
                                self.analyze(text: review.content, completionHandler: { (result) in
                                    if let result = result {
                                        if let emotionScore = self.emotionScores(of: result) {
                                            emotionScores.append(emotionScore)
                                        }
                                    }
                                    dispathGroup.leave()
                                })
                            }
                            
                            dispathGroup.notify(queue: DispatchQueue.main, execute: {
                                if let emotionScoreAverage = self.emotionAverage(emotionScores) {
                                    self.analysisCard.setBars(joy: emotionScoreAverage.joy, anger: emotionScoreAverage.anger, disgust: emotionScoreAverage.disgust, sadness: emotionScoreAverage.sadness, fear: emotionScoreAverage.fear)
                                }
                                
                                self.removeSpinner()
                                self.showCard()
                            })
                            
                        } else {
                            self.removeSpinner()
                            self.showAlert(withTitle: "No reviews", message: "This movie doesn't have any reviews.", andAction: nil)
                        }
                        
                    })
                } else {
                    self.removeSpinner()
                    self.showAlert(withTitle: "Movie not found", message: "I couldn't find this movie. Try another one.", andAction: { (_) in
                        self.movieTextField.text = ""
                    })
                }
            }
        } else {
            self.removeSpinner()
            self.showAlert(withTitle: "Empty name", message: "Type a movie name", andAction: nil)
        }
    }
    
    func showAlert(withTitle title: String, message: String, andAction actionHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: actionHandler)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
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
        if let movieID = movieID {
            let url = "https://www.themoviedb.org/movie/\(movieID)/reviews"
            
            if let url = URL(string: url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    //MARK: - Analysis card
    
    func showCard() {
        UIView.animate(withDuration: 0.5, animations: {
            self.analysisCard.transform = CGAffineTransform(translationX: 0, y: 0)
        }, completion: nil)
    }
    
    @objc func hideCard() {
        UIView.animate(withDuration: 0.5, animations: {
            self.analysisCard.transform = CGAffineTransform(translationX: 0, y: self.analysisCard.frame.size.height)
        }, completion: nil)
    }
    
    @objc func dismissViewOrKeyboard() {
        if(movieTextField.isFirstResponder) {
            view.endEditing(true)
        } else {
            self.movieID = nil
            hideCard()
        }
    }
    
    // MARK: - Spinner

    func showSpinner() {
        let spinnerView = UIView(frame: self.view.frame)
        spinnerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
        }
        
        self.spinnerView = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinnerView?.removeFromSuperview()
            self.spinnerView = nil
        }
    }
    
    // MARK: - Actions
    
    @IBAction func analyzeMovie(_ sender: Any) {
        self.showSpinner()
        self.dismissViewOrKeyboard()
        
        if let movieName = self.movieTextField.text {
            self.analyze(movieNamed: movieName)
        } else {
            self.removeSpinner()
        }
        
        self.movieTextField.text = ""

    }

}

