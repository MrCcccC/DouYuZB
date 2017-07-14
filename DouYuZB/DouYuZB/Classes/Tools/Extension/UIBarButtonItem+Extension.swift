//
//  UIBarButtonItem+Extension.swift
//  DouYuZB
//
//  Created by Chuchet on 2017/7/14.
//  Copyright © 2017年 mytrainning. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    class func  createItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:highImageName), for:.highlighted)
        btn.frame = CGRect(origin: .zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
    
}
