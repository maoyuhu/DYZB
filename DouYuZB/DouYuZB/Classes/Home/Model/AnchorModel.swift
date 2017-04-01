//
//  AnchorModel.swift
//  DouYuZB
//
//  Created by maoxiaohu on 17/3/31.
//  Copyright © 2017年 rss. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {

    // 房间id
    var room_id :Int = 0
    //房间图片对应的UrlString 
    var room_src:String = ""
    //0:电脑直播 1 手机直播
    var isVertical = 0
    // 房间名称
    var room_name:String = ""
    // Z主播名称
    var  nickname:String = ""
    // 在线人数
    var  online:Int = 0
    
    // 所在城市
    var anchor_city : String = ""
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
