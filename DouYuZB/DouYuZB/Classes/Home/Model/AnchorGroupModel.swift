//
//  AnchorGroupModel.swift
//  DouYuZB
//
//  Created by maoxiaohu on 17/3/31.
//  Copyright © 2017年 rss. All rights reserved.
//

import UIKit

class AnchorGroupModel: NSObject {

       // 该组中对应的房间信息 (room_list数组里面嵌套模型)
    var room_list:[[String:Any]]?{
        didSet{
            guard let room_list = room_list  else {return}
            for dict in room_list {
                anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    // 定义主播的模型对应数组
    lazy var anchors :[AnchorModel] = [AnchorModel]()

    var tag_id:String?
    // 组显示的标题
    var tag_name:String?
    // 组显示的icon
    var icon_name:String = "home_header_normal"
    
   
    
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        // 防止报错
    }
    // 和上面的didSet效果一致  不能同时出现 
//    override func setValue(_ value: Any?, forKey key: String) {
//        
//    }
}
