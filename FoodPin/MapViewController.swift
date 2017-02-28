//
//  MapViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/26.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var restaurantAtMapView: RestaurantMO!
    
    //showPicture#2
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "My pin"
        //showPicture#3 先確認annotation是否為MKUserLocation（使用者位置）
        //如果是，則回傳nil 不以PinAnnotation表示
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        //showPicture#4 為了性能起見，重複使用標誌示圖，建立一個重複使用的annotationView: MKPinAnnotationView?
        //由於一開始可能沒有，因此假設時先？，建立了再轉(as?) 為 MKPinAnnotationView
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        //showPicture#5 若沒有 annotationView
        if annotationView == nil {
            //showPicture#6 則將物件實例化
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            //showPicture#6 允許顯示示圖
            annotationView?.canShowCallout = true
        }
        
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(data: restaurantAtMapView.image as! Data)
        
        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.pinTintColor = UIColor.brown
        
        return annotationView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // showPicture#1 為了增加圖片（修改標誌示圖）必須請求協定！
        mapView.delegate = self
        
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.showsTraffic = true
        
        
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(restaurantAtMapView.location!, completionHandler: {
            placemarks, error in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurantAtMapView.name
                annotation.subtitle = self.restaurantAtMapView.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    //在地圖上顯示你的 annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    //在地圖上顯示 annotation 資訊
                    self.mapView.selectAnnotation(annotation, animated: true)

                    
                    
                }
            }
            
        })
        
        
        
        
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
