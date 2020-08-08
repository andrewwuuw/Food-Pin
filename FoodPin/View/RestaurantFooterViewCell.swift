//
//  RestaurantFooterViewCell.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/8.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class RestaurantFooterViewCell: UIView {

    @IBOutlet var rateButton: UIButton! {
        didSet {
            rateButton.layer.cornerRadius = 25.0
            rateButton.clipsToBounds = true
        }
    }

}
