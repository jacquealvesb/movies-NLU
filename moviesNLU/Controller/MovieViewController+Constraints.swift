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
    }
    
    func posterConstraints(_ orientation: UIDeviceOrientation) {
        var constraints: [NSLayoutConstraint] = []
        
        self.posterImageView.removeFromSuperview()
        self.view.addSubview(posterImageView)
        
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if orientation == .portrait || orientation == .faceUp || orientation == .faceDown {
            constraints.append( // Height constraint
                NSLayoutConstraint(item: self.posterImageView,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .height,
                                   multiplier: 0.4,
                                   constant: 0)
            )
            constraints.append( // Width constraint
                NSLayoutConstraint(item: self.posterImageView,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .height,
                                   multiplier: 1/1.5,
                                   constant: 0)
            )
            constraints.append( // Align X
                NSLayoutConstraint(item: self.posterImageView,
                                   attribute: .centerX,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .centerX,
                                   multiplier: 1,
                                   constant: 0)
            )
            constraints.append( // Top constraint
                NSLayoutConstraint(item: self.posterImageView,
                                   attribute: .top,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 50)
            )
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            constraints.append( // Height constraint
                NSLayoutConstraint(item: self.posterImageView,
                                   attribute: .height,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .height,
                                   multiplier: 1,
                                   constant: 0)
            )
            constraints.append( // Width constraint
                NSLayoutConstraint(item: self.posterImageView,
                                   attribute: .width,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .height,
                                   multiplier: 1/1.5,
                                   constant: 0)
            )
            constraints.append( // Leading constraint
                NSLayoutConstraint(item: self.posterImageView,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 0)
            )
            constraints.append( // Align Y
                NSLayoutConstraint(item: self.posterImageView,
                                   attribute: .centerY,
                                   relatedBy: .equal,
                                   toItem: self.view,
                                   attribute: .centerY,
                                   multiplier: 1,
                                   constant: 0)
            )
        }
        
        NSLayoutConstraint.activate(constraints)
        
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
                                   constant: 0)
            )
        } else if orientation == .landscapeLeft || orientation == .landscapeRight {
            constraints.append( // Leading constraint
                NSLayoutConstraint(item: self.nameLabel,
                                   attribute: .leading,
                                   relatedBy: .equal,
                                   toItem: self.posterImageView,
                                   attribute: .leading,
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
}
