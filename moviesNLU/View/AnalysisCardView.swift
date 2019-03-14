//
//  AnalysisCardView.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 13/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class AnalysisCardView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var joyProgressView: UIProgressView!
    @IBOutlet weak var joyPercentageLabel: UILabel!
    @IBOutlet weak var angerProgressView: UIProgressView!
    @IBOutlet weak var angerPercentageLabel: UILabel!
    @IBOutlet weak var disgustProgressView: UIProgressView!
    @IBOutlet weak var disgustPercentageLabel: UILabel!
    @IBOutlet weak var sadnessProgressView: UIProgressView!
    @IBOutlet weak var sadnessPercentageLabel: UILabel!
    @IBOutlet weak var fearProgressView: UIProgressView!
    @IBOutlet weak var fearPercentageLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    func commonInit(){
        Bundle.main.loadNibNamed("AnalysisCardView", owner: self, options: nil)
        addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //Making progress bar rounded
        self.joyProgressView.subviews[1].layer.cornerRadius = self.joyProgressView.layer.cornerRadius
        self.joyProgressView.subviews[1].clipsToBounds = true
        
        self.angerProgressView.subviews[1].layer.cornerRadius = self.joyProgressView.layer.cornerRadius
        self.angerProgressView.subviews[1].clipsToBounds = true
        
        self.disgustProgressView.subviews[1].layer.cornerRadius = self.joyProgressView.layer.cornerRadius
        self.disgustProgressView.subviews[1].clipsToBounds = true
        
        self.sadnessProgressView.subviews[1].layer.cornerRadius = self.joyProgressView.layer.cornerRadius
        self.sadnessProgressView.subviews[1].clipsToBounds = true
        
        self.fearProgressView.subviews[1].layer.cornerRadius = self.joyProgressView.layer.cornerRadius
        self.fearProgressView.subviews[1].clipsToBounds = true
        
    }
    
    func setBars(joy: Double?, anger: Double?, disgust: Double?, sadness: Double?, fear: Double?) {
        if let joy = joy {
            self.joyProgressView.progress = Float(joy)
            self.joyPercentageLabel.text = "\(Int(joy*100))%"
        }
        
        if let anger = anger {
            self.angerProgressView.progress = Float(anger)
            self.angerPercentageLabel.text = "\(Int(anger*100))%"
        }
        
        if let disgust = disgust {
            self.disgustProgressView.progress = Float(disgust)
            self.disgustPercentageLabel.text = "\(Int(disgust*100))%"
        }
        
        if let sadness = sadness {
            self.sadnessProgressView.progress = Float(sadness)
            self.sadnessPercentageLabel.text = "\(Int(sadness*100))%"
        }
        
        if let fear = fear {
            self.fearProgressView.progress = Float(fear)
            self.fearPercentageLabel.text = "\(Int(fear*100))%"
        }
    }
}
