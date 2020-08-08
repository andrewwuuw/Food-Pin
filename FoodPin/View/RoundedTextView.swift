//
//  RoundedTextView.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/8.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class RoundedTextView: UITextView {

    let padding = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
        self.textContainerInset = padding
    }

}
