//  MainTabBarVc.swift
//  DouYuZB
//  Created by maoxiaohu on 17/3/29.
//  Copyright © 2017年 rss. All rights reserved.


import UIKit

class MainTabBarVc: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChilVc(storyName: "Home")
        addChilVc(storyName: "Live")
        addChilVc(storyName: "Follow")
        addChilVc(storyName: "Mine")
        
    }
}
extension MainTabBarVc{

    fileprivate func addChilVc(storyName:String){
        // 1 通过storyboard 获得控制器

        let childVc = UIStoryboard.init(name: storyName, bundle: nil).instantiateInitialViewController()!
        //2 将childVc 作为子控制
        addChildViewController(childVc)
    }
}
