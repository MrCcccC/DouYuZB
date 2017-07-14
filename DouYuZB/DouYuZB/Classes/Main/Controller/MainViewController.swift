//
//  MainViewController.swift
//  DouYuZB
//
//  Created by Chuchet on 2017/7/13.
//  Copyright © 2017年 mytrainning. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
            addChildVC(stroyName: "Home")
            addChildVC(stroyName: "Live")
            addChildVC(stroyName: "Follow")
            addChildVC(stroyName: "Profile")
       
    }
    
    
    //添加子视图控制器
    private func addChildVC(stroyName:String){
        //1.通过故事版获取控制器
        let childVc = UIStoryboard(name: stroyName, bundle: nil).instantiateInitialViewController()!
        //2.将子视图控制器加入
        addChildViewController(childVc)
    }  
   
}
