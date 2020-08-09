//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by chiaqingwu on 2020/8/8.
//  Copyright © 2020 AppCoda. All rights reserved.
//

import UIKit

class NewRestaurantController:
    UITableViewController,
    UITextFieldDelegate,
    UITextViewDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
{

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        self.setTableView()
        
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
    
    @IBOutlet var photoImageView: UIImageView!
    
    //MARK: - text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextTextField = view.viewWithTag(textField.tag + 1) else { return false }
        textField.resignFirstResponder()
        nextTextField.becomeFirstResponder()
        return true
    }
    
    //MARK: - table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "",
                                                                 message: "選擇您的相片來源",
                                                                 preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "相機", style: .default, handler: { (action) in
                // 詢問相片存取的權限
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "相片圖庫", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
                photoSourceRequestController.dismiss(animated: true, completion: nil)
            })
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cancelAction)
            
            if let popCoverController = photoSourceRequestController.popoverPresentationController,
                let cell = tableView.cellForRow(at: indexPath) {
                popCoverController.sourceView = cell
                popCoverController.sourceRect = cell.bounds
            }
            
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }
    
    //MARK: - image picker controller delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        self.setImageConstaint()
        dismiss(animated: true, completion: nil)
    }

    //MARK: - Private methods
    private func setTableView() {
        tableView.separatorStyle = .none
    }
    
    private func setNavigationBar() {
        guard let customFont = UIFont(name: "Rubik-Medium", size: 35.0) else { return }
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 231, green: 76, blue: 60),
            NSAttributedString.Key.font: customFont
        ]
    }
    
    private func setImageConstaint() {
        let leadingContraint = NSLayoutConstraint(item: photoImageView as Any,
                                                  attribute: .leading,
                                                  relatedBy: .equal,
                                                  toItem: photoImageView.superview,
                                                  attribute: .leading,
                                                  multiplier: 1,
                                                  constant: 0)
        
        let trailingContraint = NSLayoutConstraint(item: photoImageView as Any,
                                                   attribute: .trailing,
                                                   relatedBy: .equal,
                                                   toItem: photoImageView.superview,
                                                   attribute: .trailing,
                                                   multiplier: 1,
                                                   constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: photoImageView as Any,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: photoImageView.superview,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView as Any,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: photoImageView.superview,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        
        leadingContraint.isActive = true
        trailingContraint.isActive = true
        topConstraint.isActive = true
        bottomConstraint.isActive = true
    }
    
}
