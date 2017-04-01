//  HomeViewController.swift
//  DouYuZB
//  Created by maoxiaohu on 17/3/29.
//  Copyright © 2017年 rss. All rights reserved.


import UIKit

class HomeViewController: UIViewController {

    fileprivate lazy var pageTitleView : PageTitleView = {[weak self]
        in
    let titleViewFrame =  CGRect.init(x: 0, y: kNavBarH, width: kScreenW, height: kTitleViewH)
    let titles = ["推荐","游戏","娱乐","趣玩"]
    let titleView = PageTitleView(frame: titleViewFrame, titles: titles)
        titleView.delegate = self
    return titleView
    }()
    // 创建collectionView
    fileprivate lazy var pageContentView : PageContentView = {[weak self]
        in
        // 1 确定内容的frame
        let contentH = kScreenH - kNavBarH - kTitleViewH - kTabBarH
        let contentViewFrame = CGRect(x: 0, y: kNavBarH+kTitleViewH, width: kScreenW, height: contentH)
        // 2 确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendVc())
        for _ in 0..<3{
        let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        childVcs.append(vc)
        }
    
        let contentView = PageContentView(frame: contentViewFrame, childVcs: childVcs, parentViewController:self!)
        contentView.delegate = self
        return contentView
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI() //设置UI界面
    }
}
// MARK:---设置UI界面
extension HomeViewController{

    fileprivate func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        setupNavBar()
        // 添加titleView
        view.addSubview(pageTitleView)
        // 3添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor .purple;
    }
    fileprivate func setupNavBar(){
    // 设置导航栏
       let btnLogo = UIBarButtonItem(imageName: "logo")
       
        navigationItem.leftBarButtonItem = btnLogo
    // 2 设置右边的items
        let size = CGSize(width: 40, height: 40)
       
        /*
         // 类方法
        let historyItem = UIBarButtonItem.setupItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem.setupItem(imageName: "btn_search", hightImageName: "btn_search_clicked", size: size)
        let qrcoderItem = UIBarButtonItem.setupItem(imageName: "Image_scan", hightImageName: "Image_scan_clicked", size: size)
 */
        // 构造函数
        let historyItem = UIBarButtonItem(imageName: "image_my_history", hightImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", hightImageName: "btn_search_click", size: size)
        let qrcoderItem = UIBarButtonItem(imageName: "Image_scan", hightImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcoderItem]
    }
}

// MARK:---遵守pagetitleViewdalegate
extension HomeViewController:PageTitleViewDelegate{

    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }

}

// MARK:---pageContentView的delegate的协议
extension HomeViewController :PageContentViewDelegate{
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int){
    
    pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)

    }
}
