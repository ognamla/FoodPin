//
//  addRestaurantController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/27.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit
import CoreData

class addRestaurantController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var restaurantAtAddRestaurant:RestaurantMO!
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var typeTextField:UITextField!
    @IBOutlet var locationTextField:UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    
    
    var isVisited = true
    
    @IBAction func save(sender: Any?) {
        if nameTextField.text == "" || typeTextField.text == "" || locationTextField.text == "" || phoneTextField.text == "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
        }
//        print("Name: \(nameTextField.text)")
//        print("Type: \(typeTextField.text)")
//        print("Location: \(locationTextField.text)")
//        print("Phonr: \(phoneTextField.text)")
//        print("Have you been here: \(isVisited)")
        
        // chapter 19
        // 取得 appDelegate 中 persistentContainer 變數
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            restaurantAtAddRestaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
            restaurantAtAddRestaurant.name = nameTextField.text
            restaurantAtAddRestaurant.type = typeTextField.text
            restaurantAtAddRestaurant.location = locationTextField.text
            restaurantAtAddRestaurant.phone = phoneTextField.text
            restaurantAtAddRestaurant.isVisited = isVisited
            
            if let restaurantImage = photoImageView.image {
                if let imageData = UIImagePNGRepresentation(restaurantImage) {
                    restaurantAtAddRestaurant.image = NSData(data: imageData)
                    
                }
            }
            
            print("save data to context...")
            appDelegate.saveContext()
        }
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        //yes button clicked
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = .red
            
            // Change the backgroundColor property of noButton to gray
            noButton.backgroundColor = .gray
        }
        if sender == noButton {
            isVisited = false
            // Change the backgroundColor property of yesButton to gray
            yesButton.backgroundColor = .gray
            
            // Change the backgroundColor property of noButton to red
            noButton.backgroundColor = .red
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //UIImagePickerControllerOriginalImage 為含有所有資訊的 圖 將它轉為 UIImage
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as?  UIImage {
            //選取並決定尺寸
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        // constraint 為約束
        // attibute -> leading, trailing, top, bottom...
        // relatedBy -> =, >=, <=
        // item: first item, toItem: second item
        
        // leading
        let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
        leadingConstraint.isActive = true
        
        let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal , toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
        trailingConstraint.isActive = true
        
        let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        bottomConstraint.isActive = true
        
        //關閉圖片選擇器
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 當第一個 row 被選擇後呼叫
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //UIImagePickerController
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                //
                imagePicker.delegate = self
                
                //                imagePicker.sourceType = .camera
                //                imagePicker.sourceType = .savedPhotosAlbum
                
                present(imagePicker, animated: true, completion: nil)
            }
        }
    }
}
