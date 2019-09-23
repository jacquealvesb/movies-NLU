//
//  MovieViewController+TableView.swift
//  moviesNLU
//
//  Created by Jacqueline Alves on 23/09/19.
//  Copyright © 2019 jacqueline.alves.moviesNLU. All rights reserved.
//

import UIKit

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emotions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmotionsTableViewCell.identifier, for: indexPath) as! EmotionsTableViewCell
        
        cell.setup(emotion: emotions[indexPath.row])
        
        return cell
    }
}
