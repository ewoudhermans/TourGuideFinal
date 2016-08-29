//
//  SingleRowCell.swift
//  TourGuide
//
//  Created by Ewoud Hermans on 26/01/16.
//  Copyright © 2016 Ewoud Hermans. All rights reserved.
//

import UIKit

class SingleRowCell: UITableViewCell {
    
    @IBOutlet weak var sightImage: UIImageView!
    @IBOutlet weak var sightTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
