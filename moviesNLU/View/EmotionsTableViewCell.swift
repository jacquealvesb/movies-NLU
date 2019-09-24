//
//  EmotionsTableViewCell.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 20/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class EmotionsTableViewCell: UITableViewCell {
    public static let identifier = "emotionsTableViewCell"
    
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
        self.setupScoreBar()
    }
    
    func setup(emotion: Emotion) {
        self.nameLabel.text = emotion.name
        self.scoreBar.setProgress(Float(emotion.score), animated: true)
        self.scoreLabel.text = "\(String(format: "%.1f", emotion.score * 100))%"
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
        
        self.scoreBar.layer.cornerRadius = 5
        self.scoreBar.clipsToBounds = true
    }
    
    func nameLabelConstraints() {
        self.addSubview(nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }

    func scoreLabelConstraints() {
        self.addSubview(scoreLabel)
        self.scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scoreLabel.heightAnchor.constraint(equalTo: self.heightAnchor),
            self.scoreLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15),
            self.scoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func scoreBarConstraints() {
        self.addSubview(scoreBar)
        self.scoreBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.scoreBar.leadingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor,
                                                   constant: 10),
            self.scoreBar.trailingAnchor.constraint(equalTo: self.scoreLabel.leadingAnchor,
                                                    constant: -10),
            self.scoreBar.heightAnchor.constraint(equalTo: self.heightAnchor,
                                                  multiplier: 0.3),
            self.scoreBar.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
