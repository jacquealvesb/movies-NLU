//
//  ViewController+TextFieldDelegate.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 14/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        self.showCard()
        
        return true
    }
}
