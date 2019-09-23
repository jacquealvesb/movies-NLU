//
//  EmotionsTableViewCell.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 20/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class EmotionsTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = UILabel(frame: CGRect.zero)
    let scoreBar: UIProgressView = UIProgressView(frame: CGRect.zero)
    let scoreLabel: UILabel = UILabel(frame: CGRect.zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.nameLabelConstraints()
        self.scoreLabelConstraints()
        self.scoreBarConstraints()
        
        self.setupNameLabel()
        self.setupScoreLabel()
    }
    
    func setup(emotion: Emotion) {
        self.nameLabel.text = emotion.name
        self.scoreBar.setProgress(Float(emotion.score), animated: true)
        self.scoreLabel.text = "\(emotion.score * 100)%"
    }
    
    // MARK: - Layout
    func setupNameLabel() {
        self.nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .thin)
        self.nameLabel.textColor = .white
        self.nameLabel.textAlignment = .right
    }
    
    func setupScoreLabel() {
        self.scoreLabel.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        self.scoreLabel.textColor = .lightGray
        self.scoreLabel.textAlignment = .left
    }
    
    func setupScoreBar() {
        self.scoreBar.progressTintColor = UIColor(named: "pastelOrange")
        self.scoreBar.trackTintColor = .white
    }
    
    func nameLabelConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append( // Height constraint
            NSLayoutConstraint(item: self.nameLabel,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .height,
                               multiplier: 1,
                               constant: 0)
        )
        constraints.append( // Width constraint
            NSLayoutConstraint(item: self.nameLabel,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .width,
                               multiplier: 0.25,
                               constant: 0)
        )
        constraints.append( // Leading constraint
            NSLayoutConstraint(item: self.nameLabel,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .leading,
                               multiplier: 1,
                               constant: 0)
        )
        
        NSLayoutConstraint.activate(constraints)
    }

    func scoreLabelConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append( // Height constraint
            NSLayoutConstraint(item: self.scoreLabel,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .height,
                               multiplier: 1,
                               constant: 0)
        )
        constraints.append( // Width constraint
            NSLayoutConstraint(item: self.scoreLabel,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .width,
                               multiplier: 0.15,
                               constant: 0)
        )
        constraints.append( // Trailing constraint
            NSLayoutConstraint(item: self.scoreLabel,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: 0)
        )
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func scoreBarConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.append( // Leading constraint
            NSLayoutConstraint(item: self.scoreBar,
                               attribute: .leading,
                               relatedBy: .equal,
                               toItem: self.nameLabel,
                               attribute: .trailing,
                               multiplier: 1,
                               constant: 10)
        )
        constraints.append( // Trailing constraint
            NSLayoutConstraint(item: self.scoreBar,
                               attribute: .trailing,
                               relatedBy: .equal,
                               toItem: self.scoreLabel,
                               attribute: .leading,
                               multiplier: 1,
                               constant: -10)
        )
        constraints.append( // Height constraint
            NSLayoutConstraint(item: self.scoreBar,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: self,
                               attribute: .height,
                               multiplier: 0.3,
                               constant: 0)
        )
        
        NSLayoutConstraint.activate(constraints)
    }
}
