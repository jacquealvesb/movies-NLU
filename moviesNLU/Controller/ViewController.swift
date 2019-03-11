//
//  ViewController.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 11/03/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

let apiKey = "094fd8f84048425f068f6965ca8bb6af"

class ViewController: UIViewController {

    let movie = "Jack Reacher"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMovieID(of: movie) { (id) in
            print("\n\n\nMovide ID: \(id)")
        }
    }


}

