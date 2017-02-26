//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/23.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var tableView : UITableView!
    @IBOutlet var restaurantImageView: UIImageView!
    
    // func (segue:) 按鈕觸發時 處理頁面間的資料傳遞
    @IBAction func closs(segue: UIStoryboardSegue) {
        // empty here is fine
    }
    
    // func (segue:) 按鈕觸發時 處理頁面間的資料傳遞
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
    
    // prepare(for:sender) 處理頁面間的資料傳遞
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview" {
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurantAtReview = restarant
        }
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurantAtMapView = restarant
        }
        
    }
    
    var restarant:Restaurant!
 
    
    //map
    func showMap() {
        performSegue(withIdentifier: "showMap", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //新增 show map手勢
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapGestureRecognizer)
        
        //GeoCoder 為編譯器，將地址轉換成座標
        let geoCoder = CLGeocoder()
        //增加地址字串
        geoCoder.geocodeAddressString(restarant.location, completionHandler: {
            // complete 後會回傳 placemarks(可能不止一個) 或 error
            placemarks, error in
            if error != nil {
                print(error!)
                return
            }
            
            
            if let placemarks = placemarks {
                //取得第一個座標
                let placemark = placemarks[0]
                //假設一個大頭針
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
       
        
        tableView.backgroundColor = UIColor(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 0.2)
        //        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorColor = UIColor(colorLiteralRed: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
        restaurantImageView.image = UIImage(named: restarant.image)
        title = restarant.name
        
        navigationController?.hidesBarsOnSwipe = false
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    //利用 viewWillAppear 解決 Navigation bar 是否隱藏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 表格數量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // 表格內容
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
