//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by Chuchet on 2017/7/14.
//  Copyright © 2017年 mytrainning. All rights reserved.
//

import UIKit
let SrollerLineH :CGFloat = 2
protocol PageTitleViewDelegate : class{
    func pageTitleView(titleView:PageTitleView,selectedIndex:Int)
    
}
class PageTitleView: UIView {
        //定义属性
    var titles:[String]
    var currentIndex:Int = 0
    weak var delegate:PageTitleViewDelegate?
    
    
    lazy var scrollerView:UIScrollView = {
        let scrollerView = UIScrollView()
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.scrollsToTop = false
        scrollerView.bounces = false
        return scrollerView
    }()
    lazy var titleLabels:[UILabel] = [UILabel]()

    
    lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
            //自定义构造函数
     init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//设置UI
extension PageTitleView{
 func setupUI(){
        //设置UIScroll
        addSubview(scrollerView)
        scrollerView.frame = bounds
        //添加title对应的额label
        setupTitleLabels()
        //设置底线。滚动滑块
      setupBottomLineAndScrollerLine()
    }

 func  setupTitleLabels(){
        //设置label的frame
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height  - SrollerLineH
        let labelY:CGFloat = 0
        for (index,title) in titles.enumerated(){
            //创建UIlabel
            let label = UILabel()
            //设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            let labelX:CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollerView.addSubview(label)
            titleLabels.append(label)
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }

 func setupBottomLineAndScrollerLine(){
        //添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let LineH:CGFloat = 0.6
        bottomLine.frame = CGRect(x: 0, y: frame.height-LineH, width:frame.width, height:LineH )
        addSubview(bottomLine)
        
        //添加scrollLine
        guard let firstLebel = titleLabels.first else {
            return
        }
        firstLebel.textColor = UIColor.orange   
        scrollerView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLebel.frame.origin.x, y: frame.height-SrollerLineH, width: firstLebel.frame.width, height: SrollerLineH)
    }
    
}


//监听lebel的点击事件
extension PageTitleView{
    @objc func titleLabelClick(tapGes:UITapGestureRecognizer){
        //获取当前label的下标志
        guard   let currentLable  = tapGes.view as? UILabel else{
            return
        }
        //获取之前的label
        let oldLabel = titleLabels[currentIndex]
        
        //切换颜色
        currentLable.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        currentIndex = currentLable.tag
        //滚动条位置发生改变
        let scrollLineX = CGFloat(currentLable.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.35) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentLable.tag)
    }
}



