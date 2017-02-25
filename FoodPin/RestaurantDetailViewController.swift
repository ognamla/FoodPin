//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/23.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var restaurantImageView: UIImageView!
    @IBAction func closs(segue: UIStoryboardSegue) {
        // empty here is fine
    }
    @IBAction func ratingButtonTapped(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            restarant.isVisited = true
            switch rating {
            case "great" : restarant.rating = "Absolutelylove it, Must try."
            case "good"  : restarant.rating = "Pretty good."
            case "dislike" : restarant.rating = "I don't like it."
            default : restarant.rating = ""
                
            }
        }
        //重要喔！
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview" {
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurantAtReview = restarant
        }
    }
    
    var restarant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 0.2)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
        restaurantImageView.image = UIImage(named: restarant.image)
        title = restarant.name
        
        navigationController?.hidesBarsOnSwipe = false
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            cell.fieldLabel.text = "Phone"
            cell.valueLabel.text = restarant.phone
        case 4:
            cell.fieldLabel.text = "Been here"
            cell.valueLabel.text = (restarant.isVisited) ? "Yes, I've been here before. \(restarant.rating)" : "No"
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
            
        }
        cell.backgroundColor = .clear
        return cell
        
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
