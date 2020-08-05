//
//  UINavigationController+Extension.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/5.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childForStatusBarStyle: UIViewController? { topViewController }
}
