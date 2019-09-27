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
    // Objects
    let analyzeButton: RoundButton = RoundButton(color: UIColor(named: "darkGray")!, text: "analyze")
    let lineView: LineView = LineView()
    let movieTextField: MovieTextField = MovieTextField(placeholder: "type a movie")
    
    // Variables
    var spinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.movieTextField.delegate = self
        self.analyzeButton.addTarget(self, action: #selector(analyzeMovie), for: .touchUpInside)
        
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.updateConstraints()
    }
    
    func showAlert(withTitle title: String, message: String, andAction actionHandler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: actionHandler)
        alert.addAction(ok)
        
        self.present(alert, animated: true)
    }
 
    //MARK: - Keyboard
    
    @objc func dismissKeyboard() {
        if(movieTextField.isFirstResponder) {
            view.endEditing(true)
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
        self.spinnerView?.layer.zPosition = 10
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.spinnerView?.removeFromSuperview()
            self.spinnerView = nil
        }
    }
    
    // MARK: - Analysis
    
    @objc func analyzeMovie() {
        self.showSpinner()
        self.dismissKeyboard()
        
        if let movieName = self.movieTextField.text {
            self.analyze(movieNamed: movieName)
        } else {
            self.removeSpinner()
        }
        
        self.movieTextField.text = ""

    }
    
    func analyze(movieNamed name: String) {
        if(name.trimmingCharacters(in: .whitespacesAndNewlines) != "") { //Checking if name isnt empty
            
            let movieViewController = MovieViewController()
            
            if configuration == nil {
                movieViewController.getConfiguration { (success, error) in
                    if error != nil {
                        self.removeSpinner()
                        self.showAlert(withTitle: "Something happend",
                                       message: "Try again",
                                       andAction: nil)
                    } else {
                        self.setupMovieViewController(movieViewController, withName: name)
                    }
                }
            } else {
                self.setupMovieViewController(movieViewController, withName: name)
            }
            
        } else {
            self.removeSpinner()
            self.showAlert(withTitle: "Empty name",
                           message: "Type a movie name",
                           andAction: nil)
        }
    }
    
    func setupMovieViewController(_ movieViewController: MovieViewController, withName name: String) {
        movieViewController.setup(withMovieName: name) { (success, error) in
            if let error = error {
                self.removeSpinner()
                
                switch error {
                case .movieNotFound:
                    self.showAlert(withTitle: "Movie not found",
                                   message: "I couldn't find this movie. Try another one.",
                                   andAction: { _ in
                                    self.movieTextField.text = ""
                    })
                    break
                case .noReviews:
                    self.showAlert(withTitle: "No reviews",
                                   message: "This movie doesn't have any reviews.",
                                   andAction: nil)
                    break
                default:
                    break
                }
            } else {
                self.removeSpinner()
                self.present(movieViewController, animated: true)
            }
        }
    }
}
