//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/20.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

// 說明：此 cocoa touch 文件屬於 UITableViewController，已內建些許程式碼，也不用再額外導入UITableViewDelegate 以及 UITabelViewDatasource...
// 在整個UITabel View 底下
class RestaurantTableViewController: UITableViewController {
    
    //1 建立餐廳清單，包含名稱，圖示，地點，種類...
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend.jpg", "homei.jpg", "teakha.jpg", "cafeloisl.jpg", "petiteoyster.jpg", "forkeerestaurant.jpg", "posatelier.jpg", "bourkestreetbakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "fiveleaves.jpg", "cafelore.jpg", "confessional.jpg", "barrafina.jpg", "donostia.jpg", "royaloak.jpg", "caskpubkitchen.jpg"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney", "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    //2 複寫 Tabel View 的行為（內建）
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 這裡的 UITabelViewCell 已被新 create 成 RestaurantUITabelViewCell
        
        // dequeue(出列) Reusable Cell 表示即便 Cell是有限的，仍可重複使用（例如頁面顯示10行，但有100筆資料）(內建)
        // as! 強迫 convert dequeueReusableCell 的回傳物件為 RestaurantTableViewCell
        // RestaurantTableViewCell 則是稍早建立的cocoa touch 檔案
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell
        
        //3 Cell Setting
        cell.nameLabel.text = restaurantNames[indexPath.row]
        cell.thumbnailImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.locationLabel.text = restaurantLocations[indexPath.row]
        cell.typeLabel.text = restaurantTypes[indexPath.row]
        
        //將 cell imageView 變成圓形
        cell.thumbnailImageView.layer.cornerRadius = 30
        cell.thumbnailImageView.clipsToBounds = true
        
        // 9 if restaurantIsVisted true thecm show checkmark
        cell.accessoryType = restaurantIsVisted[indexPath.row] ? .checkmark : .none
        
        /* 同9
         if restaurantIsVisted[indexPath.row] {
         cell.accessoryType = .checkmark
         } else {
         cell.accessoryType = .none
         }
         */
        
        return cell
    }
    
    //4 number of sections (可省略，預設是 1)(內建)
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    //5 number of rows in section (section 內的 row number) （內建）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurantNames.count
    }
    
    //6 新增一個“點選後”會出現的功能 did Select Row at index Path
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 利用 UI Alert Controller 建立動作選單
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet) // .aleart or .actionSheet
        
        // 利用 UI Alert Action 增加動作並且
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        // 將 Alert Action 加入動作選單內
        optionMenu.addAction(cancelAction)
        
        // 建立一個 closure (action: UIAleratAction) -> Void 的 handler: callActionHandler
        // in 關鍵字為 closure 開始的地方
        let callActionHandler = {(action: UIAlertAction) -> Void in
            
            // closure 開始
            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            // closure 結束
        }
        // 建立一個  call action 屬於 UI Alert Action
        let callAction = UIAlertAction(title: "Call" + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
        // 加到 optionalMenu 裏
        optionMenu.addAction(callAction)
        
        //8 增加 check in action 屬於 UI alert action，此closure 方式 為 #81 第二種寫法
        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
            
            (action: UIAlertAction) -> Void in
            
            // 因為check mark 要顯示在 tableView 的 cell 上
            let cell = tableView.cellForRow(at: indexPath)
            // 附屬類型
            cell?.accessoryType = .checkmark
            self.restaurantIsVisted[indexPath.row] = true
        })
        
        if restaurantIsVisted[indexPath.row] == false {
            optionMenu.addAction(checkInAction)
        }
        
        //10
        let undoCheckInActionHandler = {(action: UIAlertAction) -> () in
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            self.restaurantIsVisted[indexPath.row] = false
        }
        if restaurantIsVisted[indexPath.row] == true {
            let undoCheckInAction = UIAlertAction(title: "Undo check in", style: .default, handler: undoCheckInActionHandler)
            optionMenu.addAction(undoCheckInAction)
        }
        
        
        //讓選過的灰色框不要一直留著
        tableView.deselectRow(at: indexPath, animated: false)
        
        // 顯示：
        present(optionMenu, animated: true, completion: nil)
    }
    
    //7 create an Array filled of false
    var restaurantIsVisted = Array(repeating: false, count: 21)
    
    /*11 comit:for row at 用來處理特定列的刪除或插入
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     
     if editingStyle == .delete {
     restaurantNames.remove(at: indexPath.row)
     restaurantTypes.remove(at: indexPath.row)
     restaurantLocations.remove(at: indexPath.row)
     restaurantImages.remove(at: indexPath.row)
     
     }
     // tableView.reloadData()
     tableView.deleteRows(at: [indexPath], with: .fade)
     
     }*/
    //12 滑動帶出動作 edit action for row at
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //share action
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: {
            (action, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurantNames[indexPath.row]
            
            //share image 不確定是否有image 因此用if let
            if let imageToShare = UIImage(named: self.restaurantImages[indexPath.row]) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)

            }
        })
        
        //delete action
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {
            (action, indexPath) -> Void in
            
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantTypes.remove(at: indexPath.row)
            self.restaurantLocations.remove(at: indexPath.row)
            self.restaurantImages.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade )
            
        })
        
        shareAction.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(colorLiteralRed: 202.0/255, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
