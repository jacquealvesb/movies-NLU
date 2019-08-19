//
//  ViewController.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 11/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let apiKey = TheMovieDBApiKey
    var configuration: Configuration?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getConfiguration { (configuration) in
            if let configuration = configuration {
                self.configuration = configuration
            }
        }
        
    }


}

