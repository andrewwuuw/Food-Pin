//
//  RestaurantHeaderView.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/2.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class RestaurantHeaderView: UIView {

    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
            nameLabel.shadowColor = .black
            nameLabel.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            typeLabel.layer.cornerRadius = 5
            typeLabel.layer.masksToBounds = true
        }
    }
    @IBOutlet var heartImageView: UIImageView! {
        didSet {
            heartImageView.image = UIImage(named: "heart-tick")?.withRenderingMode(.alwaysTemplate)
            heartImageView.tintColor = .white
        }
    }

}
