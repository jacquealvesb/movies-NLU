//
//  RoundButton.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 13/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class RoundButton: UIButton {
    let label = UILabel(frame: CGRect.zero)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(color: UIColor, text: String) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = color
        self.layer.cornerRadius = 25
        
        self.labelSetup(text: text)
        
        self.addSubview(label)
        
        self.setShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setLabelConstraints()

    }
    
    func setLabelConstraints() {
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.textAlignment = .center
        
        let topConstraint = NSLayoutConstraint(item: self.label,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 10)
        let bottomConstraint = NSLayoutConstraint(item: self.label,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: -10)
        let leadingConstraint = NSLayoutConstraint(item: self.label,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: 20)
        let trailingConstraint = NSLayoutConstraint(item: self.label,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: -20)
        
        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1
    }
    
    func labelSetup(text: String) {
        self.label.textColor = .white
        self.label.font = UIFont.systemFont(ofSize: 34, weight: .thin)
        self.label.textAlignment = .center
        self.label.adjustsFontSizeToFitWidth = true
        
        self.label.text = text
    }
}
