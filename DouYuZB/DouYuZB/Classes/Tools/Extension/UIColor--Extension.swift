//
//  UIColor--Extension.swift
//  DouYuZB
//
//  Created by maoxiaohu on 17/3/29.
//  Copyright © 2017年 rss. All rights reserved.
//

import UIKit
extension UIColor{
    // UIColor扩展方法 扩充便利构造函数函数 扩充哪个便利构造函数呢::  self.init(r: r, g: g, b: b)

    convenience  init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }

}
