//  PageTitleView.swift
//  DouYuZB
//  Created by maoxiaohu on 17/3/29.
//  Copyright © 2017年 rss. All rights reserved.


import UIKit
// class表示只能被类遵守 定义一些协议
protocol PageTitleViewDelegate:class {
    func pageTitleView(titleView:PageTitleView,selectedIndex index:Int)
}
// 定义一些常量
fileprivate let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
fileprivate let kSelectorColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

fileprivate let kscrollViewH:CGFloat = 2
class PageTitleView: UIView {
    

    weak var delegate:PageTitleViewDelegate?
    // MARK:---定一些属性文字
    fileprivate var titles :[String]

    // 记录label
    fileprivate  lazy var lables : [UILabel] = [UILabel]()
    
    // 上一个lab
    fileprivate var currentIndex = 0
 
    
    // scrollView的懒加载
    fileprivate  lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    //   scrollviewLine的懒加载
    fileprivate  lazy var scrollViewLine : UIView = {
        let scrollViewLine = UIView()
        scrollViewLine.backgroundColor = UIColor.orange
        return scrollViewLine
    }()
    
// MARK:---自定义一个构造函数 系统自带的不够用再加一个titles
    init(frame:CGRect,titles :[String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        // 设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// 定义PageTitleView类
extension PageTitleView{
    
   fileprivate func setupUI(){
    // 1 添加UIScrollView
        addSubview(scrollView)
    scrollView.frame = bounds
    // 2 添加label
        setupLabel()
    // 3创建底线
        setupBottomUI()
    }
  fileprivate  func setupLabel(){
    
        let labW :CGFloat = frame.width / CGFloat(titles.count)
        let labH :CGFloat = frame.height - kscrollViewH
        let labY :CGFloat = 0
        // 即可拿到元素 也可以拿到下标
        for (index,title) in titles.enumerated() {
            // 1 穿件UIlebl
            let label : UILabel = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            // 2 设置label的frame
            let labX :CGFloat = labW * CGFloat(index)
            label.frame = CGRect(x: labX, y: labY, width: labW, height: labH)
            label.isUserInteractionEnabled = true
           scrollView.addSubview(label)
            lables.append(label)
            
            // 3给label 添加手势
            let tap = UITapGestureRecognizer(target: self, action: #selector(labClick(tap:)))
            label.addGestureRecognizer(tap)
        }
    }
    fileprivate  func setupBottomUI(){
    // 添加底线
        let bottonLine = UIView()
        bottonLine.backgroundColor = UIColor.lightGray
        let lineH :CGFloat = 0.5
        bottonLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottonLine)
        
        // 2 添加scrollviewline
        // 2.1 获取第一个label
        guard let fistLabel = lables.first else {return}
        fistLabel.textColor = UIColor.init(r: kSelectorColor.0, g: kSelectorColor.1, b: kSelectorColor.2)
        scrollView.addSubview(scrollViewLine)
    scrollViewLine.frame = CGRect(x: fistLabel.frame.origin.x, y: frame.height - kscrollViewH, width: fistLabel.frame.width, height: kscrollViewH)
    }
}
extension PageTitleView {

      func labClick(tap:UITapGestureRecognizer){
    // 1 获取当前label
       
    guard let currentLabel = tap.view as? UILabel else {return}
        
        // 2 获取之前的label
        let oldLab = lables[currentIndex]
        
        // 2.1切换文字的颜色
        currentLabel.textColor = UIColor.init(r: kSelectorColor.0, g: kSelectorColor.1, b: kSelectorColor.2)
        oldLab.textColor = UIColor.init(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 3 保存最新label的下标值
        currentIndex = currentLabel.tag
        
        // 4 滚动条的位置发生改变
        let scrollLinePositionX = CGFloat(currentLabel.tag) * scrollViewLine.frame.width
        UIView.animate(withDuration: 0.25) { 
            self.scrollViewLine.frame.origin.x = scrollLinePositionX
        }
         // 5 通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}
// MARK:---对外暴露方法
extension PageTitleView{

    func setTitleWithProgress(progress:CGFloat,sourceIndex:Int,targetIndex:Int) {
        // 1 取出sourceIndexLabel/targetLabel 
        let sourceLabel = lables[sourceIndex]
        let targetLabel = lables[targetIndex]
        
        // 2 处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollViewLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        // 3颜色的渐变
        //3.1 取出变化的范围
        let colorDelta = (kSelectorColor.0-kNormalColor.0,kSelectorColor.1-kNormalColor.1,kSelectorColor.2-kNormalColor.2)
        
        // 3.2 变化 sourceLab
        sourceLabel.textColor = UIColor(r: kSelectorColor.0 - colorDelta.0*progress, g: kSelectorColor.1 - colorDelta.1*progress, b: kSelectorColor.2 - colorDelta.2*progress)
        // 3.3 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0*progress, g: kSelectorColor.1 - colorDelta.1*progress, b: kSelectorColor.2 - colorDelta.2*progress)
        // 4 记录最新的index
        currentIndex = targetIndex
    }
}
