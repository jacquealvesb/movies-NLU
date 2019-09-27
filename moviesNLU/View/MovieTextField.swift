//
//  MovieTextField.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 16/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class MovieTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String) {
        super.init(frame: CGRect.zero)
        self.placeholder = placeholder
        
        self.layout()
    }

    func layout() {
        self.borderStyle = .none
        
        self.font = UIFont.systemFont(ofSize: 34, weight: .thin)
        self.textColor = UIColor(named: "darkGray")!
        self.minimumFontSize = 17
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = .center
        self.contentVerticalAlignment = .bottom
    }
}
