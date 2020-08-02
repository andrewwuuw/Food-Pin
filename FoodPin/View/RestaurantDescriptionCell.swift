//
//  RestaurantDescriptionCell.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/2.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class RestaurantDescriptionCell: UITableViewCell {

    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
