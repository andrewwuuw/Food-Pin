//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/8.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class NewRestaurantController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - UI
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.delegate = self
        }
    }

    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }

    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }

    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }

    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.delegate = self
        }
    }
    
    //MARK: - text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextTextField = view.viewWithTag(textField.tag + 1) else { return false }
        textField.resignFirstResponder()
        nextTextField.becomeFirstResponder()
        return true
    }

}
