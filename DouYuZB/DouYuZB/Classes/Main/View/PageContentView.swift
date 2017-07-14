//
//  PageContentView.swift
//  DouYuZB
//
//  Created by Chuchet on 2017/7/14.
//  Copyright © 2017年 mytrainning. All rights reserved.
//

import UIKit
private let ContentcellID = "huhu"

class PageContentView: UIView {
    //定义属性
    
    var childVc:[UIViewController]
 fileprivate weak var parentViewContrller:UIViewController?
    lazy var collectionView:UICollectionView={
            weak var _self = self
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = _self!.bounds.size
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        //创建UicollectionVIew
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator  = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentcellID)
        return collectionView
    }()
    
    
    //自定义构造函数
    init(frame: CGRect,childVc:[UIViewController],parentViewController:UIViewController) {
        self.childVc = childVc
        self.parentViewContrller = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//设置UI界面
extension PageContentView{
    //设置UI
    func setupUI(){
        for childVc in childVc{
            parentViewContrller?.addChildViewController(childVc)
        }
        //添加UICollectionView，用于在cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
    
    
}
//遵守UIcollectionView 的协议
extension PageContentView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVc.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentcellID, for: indexPath)
        //给cell设置内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childvc = childVc[indexPath.item]
        childvc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childvc.view)
        return cell
    }
    
}

//对外暴露的方法
extension PageContentView{
    func setCurrentIndex(currentIndex:Int){
        let  offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y:0), animated: false)
    }
}
