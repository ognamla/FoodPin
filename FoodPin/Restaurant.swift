//
//  Restaurant.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/23.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import Foundation

class Restaurant {
    var name:String = ""
    var type:String = ""
    var location:String = ""
    var image:String = ""
    var phone:String = ""
    var isVisited:Bool = false
    var rating = ""
    
    init(name:String, type:String, location:String, phone:String, image:String,  isVisited:Bool ) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        self.phone = phone
        
    }

}
