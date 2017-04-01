//
//  RecommendViewModel.swift
//  DouYuZB
//
//  Created by maoxiaohu on 17/3/31.
//  Copyright © 2017年 rss. All rights reserved.
//

import UIKit
import Alamofire
class RecommendViewModel{

    // MARK:---数组
    fileprivate var anchorGroups :[AnchorGroupModel] = [AnchorGroupModel]()
}
// MARK:---发送网络请求

extension RecommendViewModel{

    func requestData()  {
        // 0 定义参数
        let parameters = ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
        // 1 请求推荐数据
        
        // 2 请求颜值数据
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            print(result)
        }
        // 3 请求后面部分的游戏数据
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            
            // 1 将result转成字典类型
            guard let resultDict = result as? [String:Any] else{return}
            
            
            //2 根据data的key 获取数组
            guard   let dataArr = resultDict["data"] as? [[String:Any]] else{return}
            
            //3 便利数组 获取字典  将字典转成模型
            for dict in dataArr{
            
            let group = AnchorGroupModel.init(dict: dict)
            self.anchorGroups.append(group)
             }
    }

    }


}
