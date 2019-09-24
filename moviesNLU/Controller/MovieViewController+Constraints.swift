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
                self.posterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4),
                self.posterImageView.widthAnchor.constraint(equalTo: self.posterImageView.heightAnchor, multiplier: 1/1.5),
                self.posterImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.posterImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50)
                
            ])
            
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            NSLayoutConstraint.activate([
                self.posterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                self.posterImageView.widthAnchor.constraint(equalTo: self.posterImageView.heightAnchor, multiplier: 1/1.5),
                self.posterImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.posterImageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            ])
        }
    }
    
    func nameLabelConstraints(_ orientation: UIDeviceOrientation) {
        var constraints: [NSLayoutConstraint] = []
        
        self.nameLabel.removeFromSuperview()
        self.view.addSubview(nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            constraints.append( // Width constraint
                NSLayoutConstraint(item: self.nameLabel,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .width,
                                   multiplier: 1.5,
                                   constant: 0)
            )
            constraints.append( // Align X
                NSLayoutConstraint(item: self.nameLabel,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .centerX,
                                   multiplier: 1,
                                   constant: 0)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.nameLabel,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 10)
            )
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            constraints.append( // Leading constraint
                NSLayoutConstraint(item: self.nameLabel,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: 20)
            )
            constraints.append( // Trailing constraint
                NSLayoutConstraint(item: self.nameLabel,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: -20)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.nameLabel,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 20)
            )
        }
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func analysisLabelConstraints(_ orientation: UIDeviceOrientation) {
        var constraints: [NSLayoutConstraint] = []
        
        self.reviewsAnalysisLabel.removeFromSuperview()
        self.view.addSubview(reviewsAnalysisLabel)
        
        self.reviewsAnalysisLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            constraints.append( // Width constraint
                NSLayoutConstraint(item: self.reviewsAnalysisLabel,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .width,
                                   multiplier: 0.6,
                                   constant: 0)
            )
            constraints.append( // Leading constraint
                NSLayoutConstraint(item: self.reviewsAnalysisLabel,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 20)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.reviewsAnalysisLabel,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.nameLabel,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 30)
            )
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            constraints.append( // Leading constraint
                NSLayoutConstraint(item: self.reviewsAnalysisLabel,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: 20)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.reviewsAnalysisLabel,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.nameLabel,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 30)
            )
        }
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func readReviewsButtonConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        self.readReviewsButton.removeFromSuperview()
        self.view.addSubview(readReviewsButton)
        
        self.readReviewsButton.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append( // Leading constraint
            NSLayoutConstraint(item: self.readReviewsButton,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.reviewsAnalysisLabel,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: 0)
        )
        constraints.append( // Trailing constraint
            NSLayoutConstraint(item: self.readReviewsButton,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.view,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: -20)
        )
        constraints.append( // Center Y
            NSLayoutConstraint(item: self.readReviewsButton,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: self.reviewsAnalysisLabel,
                               attribute: .bottom,
                               multiplier: 1,
                               constant: 0)
        )
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func emotionsTableViewConstraints(_ orientation: UIDeviceOrientation) {
        var constraints: [NSLayoutConstraint] = []
        
        self.emotionsTableView.removeFromSuperview()
        self.view.addSubview(emotionsTableView)
        
        self.emotionsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            constraints.append( // Leading constraint
                NSLayoutConstraint(item: self.emotionsTableView,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 20)
            )
            constraints.append( // Trailing constraint
                NSLayoutConstraint(item: self.emotionsTableView,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: -20)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.emotionsTableView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.reviewsAnalysisLabel,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 30)
            )
            constraints.append( // Bottom constraint
                NSLayoutConstraint(item: self.emotionsTableView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: -30)
            )
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            constraints.append( // Leading constraint
                NSLayoutConstraint(item: self.emotionsTableView,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: 20)
            )
            constraints.append( // Trailing constraint
                NSLayoutConstraint(item: self.emotionsTableView,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: -20)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.emotionsTableView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.reviewsAnalysisLabel,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: 30)
            )
            constraints.append( // Bottom constraint
                NSLayoutConstraint(item: self.emotionsTableView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .bottom,
                                   multiplier: 1,
                                   constant: -30)
            )
        }
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    func closeButtonConstraints(_ orientation: UIDeviceOrientation) {
        var constraints: [NSLayoutConstraint] = []
        
        self.closeButton.removeFromSuperview()
        self.view.addSubview(closeButton)
        
        self.closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            constraints.append( // Trailing constraint
                NSLayoutConstraint(item: self.closeButton,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 20)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.closeButton,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: -10)
            )
            constraints.append( // Height constraint
                NSLayoutConstraint(item: self.closeButton,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: 100)
            )
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            constraints.append( // Leading constraint
                NSLayoutConstraint(item: self.closeButton,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .trailing,
                                   multiplier: 1,
                                   constant: 20)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.closeButton,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: -20)
            )
            constraints.append( // Height constraint
                NSLayoutConstraint(item: self.closeButton,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: nil,
                                   attribute: .notAnAttribute,
                                   multiplier: 1,
                                   constant: 100)
            )
        }
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
