//
//  UIBarButtonItem-Exension.swift
//  DouYuZB
//
//  Created by maoxiaohu on 17/3/29.
//  Copyright © 2017年 rss. All rights reserved.
//创建一个源文件 直接扩展 写成这样extension UIBarButtonItem{
//}

import UIKit

extension UIBarButtonItem{

    // 类方法   swift建议用够着函数
    /*
    class func setupItem(imageName:String,hightImageName:String,size:CGSize) -> UIBarButtonItem{
        
        let btn = UIButton()
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: hightImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
 */
    // 在系统自带的函数中 1 只能扩充便利构造函数 以convenience开头 2 在构造函数中必须明确调用一个设计的构造函数
    // 加上默认参数
    convenience init(imageName:String,hightImageName:String = "",size:CGSize = CGSize.zero) {
       // self.init()
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        
        if hightImageName != "" {
             btn.setImage(UIImage.init(named: hightImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
       
        self.init(customView:btn) //?
    }

    
}
