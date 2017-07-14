//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by Chuchet on 2017/7/14.
//  Copyright © 2017年 mytrainning. All rights reserved.
//

import UIKit
private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
//懒加载
        lazy var pageTitleView : PageTitleView = {
        weak var _self = self
        let titleFrame = CGRect(x: 0, y:kstatusBarH + kNavigationH , width: kScreenW,height: kTitleViewH)
        let titles = ["游戏","推荐","娱乐","趣玩"]
        let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
        titleView.delegate = _self!
        return titleView
    }()

    lazy var pageContentView:PageContentView={
                weak var _self = self
        //确定内容的frame
        let contentH = kScreenH - kstatusBarH - kNavigationH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kstatusBarH + kNavigationH+kTitleViewH, width: kScreenW, height:contentH )
        //确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r:CGFloat(arc4random_uniform(255)) , g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
       let contentView = PageContentView(frame: contentFrame,childVc: childVcs, parentViewController: _self!)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setupUI()
    }
}

extension HomeViewController{
      func setupUI(){
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        
        //添加TitleView
        view.addSubview(pageTitleView)
        
        //添加contentView
        view.addSubview(pageContentView)
    }
    private func setupNavigationBar(){
        //1.设置左侧Item
        let size = CGSize(width: 40, height: 40)
        let btn = UIButton()
        btn.setImage(UIImage(named:"logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        //2.设置右侧的Item 
             let historyItem = UIBarButtonItem.createItem(imageName: "searchIconDark", highImageName: "search_icon_orange_HL", size: size)
             let searchItem  = UIBarButtonItem.createItem(imageName: "icon_emoticon_normal", highImageName: "icon_emoticon_sel", size: size)
             let qrcodeItem = UIBarButtonItem.createItem(imageName: "sendDynamic_uncheck", highImageName: "sendDynamic_Checked", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem ,qrcodeItem]
        
    }
    
}

//遵守PagetitleView的协议
extension HomeViewController:PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
      pageContentView.setCurrentIndex(currentIndex: selectedIndex)
    }
    
}
