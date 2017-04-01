//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by maoxiaohu on 17/3/31.
//  Copyright © 2017年 rss. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var iconV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       iconV.layer.cornerRadius = 5
        iconV.clipsToBounds = true
    }

}
