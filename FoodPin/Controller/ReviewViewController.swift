//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/8.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var rateButtons: [UIButton]!
    
    var restaurant = Restaurant()
    
    //MARK: - lif cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundImage()
        self.setBlurEffet(on: backgroundImageView)
        self.moveRateButtonRightTransFrom()
        self.hideAllRateButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.animatedlyShowRateButton()
    }
    
    override func viewDidLayoutSubviews() {
        self.blurEffectView.frame = self.view.bounds
    }
    
    //MARK: - Private methods
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private func setBackgroundImage() {
        backgroundImageView.image = UIImage(named: restaurant.image)
    }
    
    private func setBlurEffet(on view: UIImageView) {
        view.addSubview(blurEffectView)
    }
    
    private func hideAllRateButtons() {
        rateButtons.forEach({ rateButton in
            rateButton.alpha = 0
        })
    }
    
    private func moveRateButtonRightTransFrom() {
        let moveRightTransForm = CGAffineTransform(translationX: 600, y: 0)
        let scaleUpTransFrom = CGAffineTransform(scaleX: 5, y: 5)
        rateButtons.forEach({ rateButton in
            rateButton.transform = scaleUpTransFrom.concatenating(moveRightTransForm)
        })
    }

    private func animatedlyShowRateButton() {
        let durationTime: TimeInterval = 0.4
        var delayTime: TimeInterval = 0.1
        for index in 0..<rateButtons.count {
            UIView.animate(withDuration: durationTime,
                           delay: delayTime,
                           options: [],
                           animations: {
                               self.rateButtons[index].transform = .identity
                               self.rateButtons[index].alpha = 1.0
                               delayTime += 0.05
                           }, completion: nil)
        }
    }
}
