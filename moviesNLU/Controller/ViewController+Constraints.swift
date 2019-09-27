//
//  ViewController+Constraints.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 16/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

extension ViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.updateConstraints()
    }
    
    func getOrientation() -> UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    func updateConstraints() {
        let orientation = self.getOrientation()
        
        self.lineViewConstraints(orientation)
        self.analyzeButtonConstraints(orientation)
        self.movieTextFieldConstraints()
    }
    
    func analyzeButtonConstraints(_ orientation: UIDeviceOrientation) {
        self.analyzeButton.removeFromSuperview()
        self.view.addSubview(analyzeButton)
        
        self.analyzeButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            NSLayoutConstraint.activate([
                self.analyzeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100),
                self.analyzeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100),
                self.analyzeButton.heightAnchor.constraint(equalToConstant: 56),
                self.analyzeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
            
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            NSLayoutConstraint.activate([
                self.analyzeButton.leadingAnchor.constraint(equalTo: self.lineView.trailingAnchor,
                                                            constant: 50),
                self.analyzeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                             constant: -50),
                self.analyzeButton.heightAnchor.constraint(equalToConstant: 56),
                self.analyzeButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
           ])
        }
        
    }
    
    func lineViewConstraints(_ orientation: UIDeviceOrientation) {
        self.lineView.removeFromSuperview()
        self.view.addSubview(lineView)
        
        self.lineView.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            NSLayoutConstraint.activate([
                self.lineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                       constant: 50),
                self.lineView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                        constant: -50),
                self.lineView.heightAnchor.constraint(equalToConstant: 2),
            ])
            
            let centerYConstraint =  NSLayoutConstraint(item: self.lineView,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: self.view,
                                                        attribute: .centerY,
                                                        multiplier: 0.5,
                                                        constant: 0)
            NSLayoutConstraint.activate([centerYConstraint])
                       
            
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            NSLayoutConstraint.activate([
                self.lineView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
                self.lineView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
                self.lineView.heightAnchor.constraint(equalToConstant: 2),
                self.lineView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
        
    }
    
    func movieTextFieldConstraints() {
        self.movieTextField.removeFromSuperview()
        self.view.addSubview(movieTextField)
        
        self.movieTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.movieTextField.leadingAnchor.constraint(equalTo: self.lineView.leadingAnchor),
            self.movieTextField.trailingAnchor.constraint(equalTo: self.lineView.trailingAnchor),
            self.movieTextField.heightAnchor.constraint(equalToConstant: 56),
            self.movieTextField.bottomAnchor.constraint(equalTo: self.lineView.topAnchor)
        ])
    }
}

