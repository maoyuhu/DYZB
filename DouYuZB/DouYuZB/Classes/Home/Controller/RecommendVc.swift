//  RecommendVc.swift
//  DouYuZB
//  Created by maoxiaohu on 17/3/30.
//  Copyright © 2017年 rss. All rights reserved.


import UIKit

fileprivate let kItemMargin:CGFloat = 10
fileprivate let kItemW = (kScreenW - 3*kItemMargin) / 2
fileprivate let kNormalItemH = kItemW * 3 / 4
fileprivate let kPrettyItemH = kItemW * 4 / 3
fileprivate let kHeaderView:CGFloat = 50
fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeaderViewID = "kHeaderView"

class RecommendVc: UIViewController {
    
    // MARK:---懒加载
      fileprivate  lazy var recommendVM = RecommendViewModel()
    fileprivate  lazy var collectionView : UICollectionView = {[unowned self] in
      
        //1 穿件布局
       let layout =  UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderView)
         // 2 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
         collectionView.register(UINib.init(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
         collectionView.register(UINib.init(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
         collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth] // 高度随着父控件的拉伸而拉伸 宽度也是
        return collectionView
    }()
    
    
    // MARK:---系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 发送网络请求
       loadData()
 
    }

}
// MARK:---设置UI界面
extension RecommendVc{
    func setupUI()  {
        view.addSubview(collectionView)
        
      
    }

}
// MARK:---请求网络
extension RecommendVc{


    fileprivate func loadData(){
    
   recommendVM.requestData()
    }

}

// MARK:---遵守collectionView的数据源方法
extension RecommendVc:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1 获取cell
        var cell : UICollectionViewCell!
        // 2 取出cell
        if indexPath.section == 1 {
            cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
        cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1 取出sectionView的headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: "UICollectionElementKindSectionHeader", withReuseIdentifier: kHeaderViewID, for: indexPath)
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
        if indexPath.section == 1 {
            
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
            return CGSize(width: kItemW, height: kNormalItemH)

    }
}

