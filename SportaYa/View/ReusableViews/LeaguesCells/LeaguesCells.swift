//
//  LeaguesCells.swift
//  SportaYa
//
//  Created by A7med Fekry on 26/04/2024.
//

import UIKit

class LeaguesCells: UITableViewCell {
    

    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var addLeagueToFavbtn: UIButton!
    
    var favLeague:(()->())?


    
    @IBAction func addLeagueToFav(_ sender: Any) {
        favLeague?()
    }
    
}

