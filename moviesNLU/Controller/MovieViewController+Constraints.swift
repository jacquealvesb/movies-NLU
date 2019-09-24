//
//  MovieViewController+Constraints.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 16/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

extension MovieViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.updateConstraints()
    }
    
    func getOrientation() -> UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    func updateConstraints() {
        let orientation = self.getOrientation()
        
        self.posterConstraints(orientation)
        self.nameLabelConstraints(orientation)
        self.analysisLabelConstraints(orientation)
        self.readReviewsButtonConstraints()
        self.emotionsTableViewConstraints(orientation)
        self.closeButtonConstraints(orientation)
    }
    
    func posterConstraints(_ orientation: UIDeviceOrientation) {
        self.posterImageView.removeFromSuperview()
        self.view.addSubview(posterImageView)
        
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            NSLayoutConstraint.activate([
                self.posterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                                             multiplier: 0.4),
                self.posterImageView.widthAnchor.constraint(equalTo: self.posterImageView.heightAnchor,
                                                            multiplier: 1/1.5),
                self.posterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.posterImageView.topAnchor.constraint(equalTo: self.view.topAnchor,
                                                          constant: 50)
                
            ])
            
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            NSLayoutConstraint.activate([
                self.posterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                self.posterImageView.widthAnchor.constraint(equalTo: self.posterImageView.heightAnchor,
                                                            multiplier: 1/1.5),
                self.posterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.posterImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
    }
    
    func nameLabelConstraints(_ orientation: UIDeviceOrientation) {
        self.nameLabel.removeFromSuperview()
        self.view.addSubview(nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            NSLayoutConstraint.activate([
                self.nameLabel.widthAnchor.constraint(equalTo: self.posterImageView.widthAnchor,
                                                      multiplier: 1.5),
                self.nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.nameLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor,
                                                    constant: 10)
            ])
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            NSLayoutConstraint.activate([
                self.nameLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor,
                                                        constant: 20),
                self.nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                         constant: -20),
                self.nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor,
                                                    constant: 20)
            ])
        }
        
    }
    
    func analysisLabelConstraints(_ orientation: UIDeviceOrientation) {
        self.reviewsAnalysisLabel.removeFromSuperview()
        self.view.addSubview(reviewsAnalysisLabel)
        
        self.reviewsAnalysisLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            NSLayoutConstraint.activate([
                self.reviewsAnalysisLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor,
                                                                 multiplier: 0.6),
                self.reviewsAnalysisLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                                   constant: 20),
                self.reviewsAnalysisLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,
                                                               constant: 30)
            ])
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            NSLayoutConstraint.activate([
                self.reviewsAnalysisLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 20),
                self.reviewsAnalysisLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 30)
                
            ])
        }
    }
    
    func readReviewsButtonConstraints() {
        self.readReviewsButton.removeFromSuperview()
        self.view.addSubview(readReviewsButton)
        
        self.readReviewsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.readReviewsButton.leadingAnchor.constraint(equalTo: self.reviewsAnalysisLabel.trailingAnchor),
            self.readReviewsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                             constant: -20),
            self.readReviewsButton.bottomAnchor.constraint(equalTo: self.reviewsAnalysisLabel.bottomAnchor)
        ])
    }
    
    func emotionsTableViewConstraints(_ orientation: UIDeviceOrientation) {
        self.emotionsTableView.removeFromSuperview()
        self.view.addSubview(emotionsTableView)
        
        self.emotionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            NSLayoutConstraint.activate([
                self.emotionsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                                constant: 20),
                self.emotionsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                                 constant: -20),
                self.emotionsTableView.topAnchor.constraint(equalTo: self.reviewsAnalysisLabel.bottomAnchor, constant: 30),
                self.emotionsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                               constant: -30)
            ])
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            NSLayoutConstraint.activate([
                self.emotionsTableView.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 20),
                self.emotionsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                                 constant: -20),
                self.emotionsTableView.topAnchor.constraint(equalTo: self.reviewsAnalysisLabel.bottomAnchor, constant: 30),
                self.emotionsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor,
                                                               constant: -30)
            ])
        }
    }
    
    func closeButtonConstraints(_ orientation: UIDeviceOrientation) {
        self.closeButton.removeFromSuperview()
        self.view.addSubview(closeButton)
        
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            NSLayoutConstraint.activate([
                self.closeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                          constant: 20),
                self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor,
                                                      constant: -10),
                self.closeButton.heightAnchor.constraint(equalToConstant: 100)
            ])
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            NSLayoutConstraint.activate([
                self.closeButton.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor,
                                                          constant: 20),
                self.closeButton.topAnchor.constraint(equalTo: self.view.topAnchor,
                                                      constant: -20),
                self.closeButton.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
}
