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
    @IBOutlet weak var joyBarView: UIView!
    @IBOutlet weak var joyPercentageLabel: UILabel!
    @IBOutlet weak var angerBarView: UIView!
    @IBOutlet weak var angerPercentageLabel: UILabel!
    @IBOutlet weak var disgustBarView: UIView!
    @IBOutlet weak var disgustPercentageLabel: UILabel!
    @IBOutlet weak var sadnessBarView: UIView!
    @IBOutlet weak var sadnessPercentageLabel: UILabel!
    @IBOutlet weak var fearBarView: UIView!
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
    }
}
