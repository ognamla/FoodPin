//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/23.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantDetailTableViewCell
        
        switch indexPath.row {
        case 0 :
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restarant.name
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restarant.type
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restarant.location
        case 3:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restarant.isVisited) ? "Yes, I've been here before" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
            
        }
        return cell
        
    }
    
    
    @IBOutlet var restaurantImageView: UIImageView!
    
    var restarant:Restaurant!
    
    
    
    // 內建 viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantImageView.image = UIImage(named: restarant.image)
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
