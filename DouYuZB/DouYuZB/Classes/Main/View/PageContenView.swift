//  PageContenView.swift
//  DouYuZB
//  Created by maoxiaohu on 17/3/29.
//  Copyright © 2017年 rss. All rights reserved.


import UIKit

protocol PageContentViewDelegate:class{
    func pageContentView(contentView:PageContentView,progress:CGFloat,sourceIndex:Int,targetIndex:Int)
}
fileprivate let ContentCell = "ContentCell"

class PageContentView: UIView {

    // MARK:---定义一些属性 weak只能修饰可选类型
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
   fileprivate var isForbidScrollDelegate:Bool = false
    fileprivate var startOffsetX:CGFloat = 0
    weak var delegate:PageContentViewDelegate?
    
    // MARK:---懒加载属性 [weak self] in 若引用 里面的self要加? 需要强制解包
    fileprivate  lazy var collectionView : UICollectionView = { [weak self] in
        // 1 创建layout
        let layout  = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 2 创建UicollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCell)
        return collectionView
    }()

    init(frame:CGRect,childVcs:[UIViewController],parentViewController:UIViewController) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame:frame)
        setupUI() //设置UI
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK:---设置UI的界面
extension PageContentView{

    fileprivate func setupUI(){
    // 1 将所忧子控制器添加到父控件上面
        for childVc in childVcs{
            
        parentViewController?.addChildViewController(childVc)
        
        }
    // 2 添加UIollectionView,用于在cell中存放控制器的view
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}
// MARK:---collectionViewde datasource
extension PageContentView:UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCell, for: indexPath)
        
        // 2 给cell设置内容
        for view in cell.contentView.subviews{
        view.removeFromSuperview() //cell的循环引用可能会导致多次添加  所以要移除
        }
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
// MARK:---对外暴露的方法
extension PageContentView{

    func setCurrentIndex(currentIndex:Int) {
            isForbidScrollDelegate = true // 记录需要禁止执行的代理方法
        let offsetX = CGFloat(currentIndex)*collectionView.frame.width
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
}
// MARK:---遵守UICollectionView的delegate
extension PageContentView:UICollectionViewDelegate{

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
       startOffsetX =  scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     //0 是否是点击事件
        if isForbidScrollDelegate {return} //必须加括号
        
        
     // 1 获取所需的数据
        var progress:CGFloat = 0
        var sourceIndex:Int = 0
        var  targetIndex:Int = 0
        
        // 2 判断是左划还是右滑
        let  currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {
            // 左划
            // 1 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            // 2 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 3 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count{
            targetIndex = childVcs.count - 1
            }
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
        // 优化
            // 1 计算progress
             progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            // 2 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            // 3 sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
       // 将progress/sourceindex/targetinbdex传递给titleview
       // print("\(progress)--\(sourceIndex)--\(targetIndex )")
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
