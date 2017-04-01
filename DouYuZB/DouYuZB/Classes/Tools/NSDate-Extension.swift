//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by maoxiaohu on 17/3/31.
//  Copyright © 2017年 rss. All rights reserved.
//

import Foundation


extension NSDate{

    class func getCurrentTime() ->String {
    let nowDate = NSDate()
    // 字符串类型强转Int 需要! double强转不需要!
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
        
    }
}
