//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Ognam.Chen on 2017/2/20.
//  Copyright © 2017年 SwiftCourse. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    //1 Create UI Label
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
