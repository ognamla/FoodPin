//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/25.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var restaurantimageViewatReview: UIImageView!
    @IBOutlet var clossButton: UIButton!
    
    var restaurantAtReview:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        //設定原始狀態
        containerView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        
        restaurantimageViewatReview.image = UIImage(named: restaurantAtReview.image)
        restaurantimageViewatReview.contentMode = .scaleAspectFill
        restaurantimageViewatReview.clipsToBounds = true
    }
    
    // create a viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            //回復原來狀態 .identity
            self.containerView.transform = CGAffineTransform.identity
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
