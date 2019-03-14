//
//  ViewController.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 11/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var movieTextField: UITextField!
    @IBOutlet weak var analysisCard: AnalysisCardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.analysisCard.transform = CGAffineTransform(translationX: 0, y: self.analysisCard.frame.size.height)
        self.analysisCard.closeButton.addTarget(self, action: #selector(hideCard), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissViewOrKeyboard))
        view.addGestureRecognizer(tap)
        
        self.movieTextField.delegate = self
    }

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
    
    // MARK: - Actions
    
    @IBAction func analyzeMovie(_ sender: Any) {
        dismissViewOrKeyboard()
        showCard()
    }

}

