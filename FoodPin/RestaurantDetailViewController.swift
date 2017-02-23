//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/23.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var restaurantImageView: UIImageView!
    var restaurantImage = ""
    @IBOutlet var restaurantNameLabel: UILabel!
    var restaurantName = ""
    @IBOutlet var restaurantTypeLabel: UILabel!
    var restaurantType = ""
    @IBOutlet var restaurantLocationLabel: UILabel!
    var restaurantLocation = ""
    
    
    
    
    // 內建 viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        restaurantImageView.image = UIImage(named: restaurantImage)
        restaurantNameLabel.text = restaurantName
        restaurantLocationLabel.text = restaurantLocation
        restaurantTypeLabel.text = restaurantType
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
