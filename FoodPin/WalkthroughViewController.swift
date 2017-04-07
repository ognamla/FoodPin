//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/4/4.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
        
        switch index {
        case 0...1:
            forwardButton.setTitle("Next", for: .normal)
        case 2:
            forwardButton.setTitle("Done", for: .normal)
        default:
            break
            
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    @IBAction func nextButtonTaped(_ sender: UIButton) {
        switch index {
        case 0...1 :
            let pageViewController = parent as! WalkthroughPageViewController
            pageViewController.forward(index: index)
        case 2 :
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
            dismiss(animated: true, completion: nil)
        default: break

        }
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
