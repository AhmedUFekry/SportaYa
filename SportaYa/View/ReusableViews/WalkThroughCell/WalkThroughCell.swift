//
//  WalkThroughCell.swift
//  SportaYa
//
//  Created by A7med Fekry on 26/04/2024.
//

import UIKit

class WalkThroughCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ WalkThroughModel: walkThroughModel){
        imgView.image = UIImage(named: WalkThroughModel.img)
        titleLbl.text = WalkThroughModel.title
        descLbl.text = WalkThroughModel.desc
    }

}
