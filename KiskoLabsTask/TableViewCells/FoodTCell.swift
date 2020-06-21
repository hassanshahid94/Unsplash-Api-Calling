//
//  FoodTCell.swift
//  KiskoLabsTask
//
//  Created by Hassan Shahid on 11/06/2020.
//  Copyright © 2020 Hassan Shahid. All rights reserved.
//

import UIKit

class FoodTCell: UITableViewCell {

    //MARK:- Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cvFood: UICollectionView!
    @IBOutlet weak var vwBackground: UIView!
    
    //MARK:- Load
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.endEditing(true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
