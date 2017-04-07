//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/20.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    @IBAction func unWindToHomeScreen(segue: UIStoryboardSegue) {
        
    }
    
    var searchController: UISearchController!
    // 第一次啟動app時會呼叫 pageViewController
    override func viewDidAppear(_ animated: Bool) {
       
        if UserDefaults.standard.bool(forKey: "hasViewedWalkthrough") {
            return
        }
        
        if let pageviewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController") as? WalkthroughPageViewController {
            present(pageviewController, animated: true, completion: nil)
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.hidesBarsOnSwipe = true
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // searchController
        // nil 表示搜尋結果顯示於相同視窗
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(red: 218/255, green: 100/255, blue: 70/255, alpha: 1)
        
        
        // coreData
        // 先從RestaurantMO 取得 NSFetchRequest object
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        // NSSortDescriptior 指定排序
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // 取得 appDelegate
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    restaurants = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
        
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects {
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //搜尋功能
    var searchResults:[RestaurantMO] = []
    func filterContent(for SearchText: String) {

        searchResults = restaurants.filter({
            (restaurants) -> Bool in
            if let name = restaurants.name, let location = restaurants.location, let type = restaurants.type {
                let isMatch = name.localizedCaseInsensitiveContains(SearchText) || location.localizedCaseInsensitiveContains(SearchText) || type.localizedCaseInsensitiveContains(SearchText)
                return isMatch
            }
            return false
        })
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    //1
    var restaurants:[RestaurantMO] = []
    //2 複寫 Tabel View 的行為（內建）
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { // 這裡的 UITabelViewCell 已被新 create 成 RestaurantUITabelViewCell
        
        // dequeue(出列) Reusable Cell 表示即便 Cell是有限的，仍可重複使用（例如頁面顯示10行，但有100筆資料）(內建)
        // as! 強迫 convert dequeueReusableCell 的回傳物件為 RestaurantTableViewCell
        // RestaurantTableViewCell 則是稍早建立的cocoa touch 檔案
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RestaurantTableViewCell
        
        //判斷是從搜尋結果或者原來的陣列取得餐廳
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel.text = restaurant.name
        cell.thumbnailImageView.image = UIImage(data: restaurant.image as! Data)
        cell.locationLabel.text = restaurant.location
        cell.typeLabel.text = restaurant.type
        
        
        //        //3 Cell Setting
        //        cell.nameLabel.text = restaurants[indexPath.row].name
        //        cell.thumbnailImageView.image = UIImage(data: restaurants[indexPath.row].image as! Data)
        //        cell.locationLabel.text = restaurants[indexPath.row].location
        //        cell.typeLabel.text = restaurants[indexPath.row].type
        
        //將 cell imageView 變成圓形
        cell.thumbnailImageView.layer.cornerRadius = 30
        cell.thumbnailImageView.clipsToBounds = true
        
        // 9 if restaurantIsVisted true thecm show checkmark
        cell.accessoryType = restaurant.isVisited ? .checkmark : .none
        
        /* 同9
         if restaurantIsVisted[indexPath.row] {
         cell.accessoryType = .checkmark
         } else {
         cell.accessoryType = .none
         }
         */
        
        return cell
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    //4 number of sections (可省略，預設是 1)(內建)
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    //5 number of rows in section (section 內的 row number) （內建）
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }
    
    //6 新增一個“點選後”會出現的功能 did Select Row at index Path
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        // 利用 UI Alert Controller 建立動作選單
    //        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet) // .aleart or .actionSheet
    //
    //        // 利用 UI Alert Action 增加動作並且
    //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    //        // 將 Alert Action 加入動作選單內
    //        optionMenu.addAction(cancelAction)
    //
    //        // 建立一個 closure (action: UIAleratAction) -> Void 的 handler: callActionHandler
    //        // in 關鍵字為 closure 開始的地方
    //        let callActionHandler = {(action: UIAlertAction) -> Void in
    //
    //            // closure 開始
    //            let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later", preferredStyle: .alert)
    //            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    //            self.present(alertMessage, animated: true, completion: nil)
    //            // closure 結束
    //        }
    //        // 建立一個  call action 屬於 UI Alert Action
    //        let callAction = UIAlertAction(title: "Call" + "123-000-\(indexPath.row)", style: .default, handler: callActionHandler)
    //        // 加到 optionalMenu 裏
    //        optionMenu.addAction(callAction)
    //
    //        //8 增加 check in action 屬於 UI alert action，此closure 方式 為 #81 第二種寫法
    //        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
    //
    //            (action: UIAlertAction) -> Void in
    //
    //            // 因為check mark 要顯示在 tableView 的 cell 上
    //            let cell = tableView.cellForRow(at: indexPath)
    //            // 附屬類型
    //            cell?.accessoryType = .checkmark
    //            self.restaurantIsVisted[indexPath.row] = true
    //        })
    //
    //        if restaurantIsVisted[indexPath.row] == false {
    //            optionMenu.addAction(checkInAction)
    //        }
    //
    //        //10
    //        let undoCheckInActionHandler = {(action: UIAlertAction) -> () in
    //
    //            let cell = tableView.cellForRow(at: indexPath)
    //            cell?.accessoryType = .none
    //            self.restaurantIsVisted[indexPath.row] = false
    //        }
    //        if restaurantIsVisted[indexPath.row] == true {
    //            let undoCheckInAction = UIAlertAction(title: "Undo check in", style: .default, handler: undoCheckInActionHandler)
    //            optionMenu.addAction(undoCheckInAction)
    //        }
    //
    //
    //        //讓選過的灰色框不要一直留著
    //        tableView.deselectRow(at: indexPath, animated: false)
    //
    //        // 顯示：
    //        present(optionMenu, animated: true, completion: nil)
    //    }
    //
    
    //    //11 comit:for row at 用來處理特定列的刪除或插入
    //     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    //
    //     if editingStyle == .delete {
    //     restaurantNames.remove(at: indexPath.row)
    //     restaurantTypes.remove(at: indexPath.row)
    //     restaurantLocations.remove(at: indexPath.row)
    //     restaurantImages.remove(at: indexPath.row)
    //
    //     }
    //      tableView.reloadData()
    //     tableView.deleteRows(at: [indexPath], with: .fade)
    //
    //     }
    
    //12 滑動帶出動作 edit action for row at
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        //share action
        let shareAction = UITableViewRowAction(style: .default, title: "Share", handler: {
            (action, indexPath) -> Void in
            let defaultText = "Just checking in at " + self.restaurants[indexPath.row].name!
            
            //share image 不確定是否有image 因此用if let
            if let imageToShare = UIImage(data: self.restaurants[indexPath.row].image as! Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
                
            }
        })
        
        //delete action
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: {
            (action, indexPath) -> Void in
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                
                appDelegate.saveContext()
            }
            
        })
        // Add color
        shareAction.backgroundColor = UIColor(colorLiteralRed: 48.0/255.0, green: 173.0/255.0, blue: 99.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(colorLiteralRed: 202.0/255, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        return [deleteAction, shareAction]
        
    }
    //13 Segue connection
    // prepare(for:sneder:) 使用segue傳遞資料
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //檢查 Segue 的識別碼
        if segue.identifier == "showRestaurantDetail" {
            // index Path For Selected Row
            if let indexPath = tableView.indexPathForSelectedRow {
                // 利用 segue.destination 取得目標： RestaurantDetailViewController
                let destinationController = segue.destination as! RestaurantDetailViewController
                // 目標由本頁(RestaurantTableViewController)而來
                destinationController.restarant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
                
                
            }
        }
    }
    
}
