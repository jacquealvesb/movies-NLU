//
//  ViewController.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 11/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let apiKey = "094fd8f84048425f068f6965ca8bb6af"
    var configuration: Configuration?

    @IBOutlet weak var movieTextField: UITextField!
    @IBOutlet weak var analysisCard: AnalysisCardView!
    
    var spinnerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.analysisCard.transform = CGAffineTransform(translationX: 0, y: self.analysisCard.frame.size.height)
        self.analysisCard.closeButton.addTarget(self, action: #selector(hideCard), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissViewOrKeyboard))
        view.addGestureRecognizer(tap)
        
        self.movieTextField.delegate = self
        
        self.getConfiguration { (configuration) in
            if let configuration = configuration {
                self.configuration = configuration
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
        showSpinner()
        dismissViewOrKeyboard()
    }

}

