//
//  WebViewController.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/4/4.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {

    var webView : WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "http://appcoda.com/contact") {
            let request = URLRequest(url:url)
            webView.load(request)
        }

    }
    override func loadView() {
        webView = WKWebView()
        view = webView
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
