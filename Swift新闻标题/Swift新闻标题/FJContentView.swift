//
//  FJContentView.swift
//  Swift新闻标题
//
//  Created by webplus on 17/10/21.
//  Copyright © 2017年 sanyi. All rights reserved.
//

import UIKit

class FJContentView: UIView,UIScrollViewDelegate {
    
    fileprivate var buttonArray:[UIButton]!
    fileprivate var titleArray:[String]!
    fileprivate var configure:FJConfigure!
    fileprivate let navHeight:CGFloat = 64.0
    fileprivate let padding:CGFloat = 2.0
    fileprivate var titleViewHeight:CGFloat!
    //承载子控制器的视图
    lazy var scrollView:UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.frame = CGRect.init(x: 0, y: self.titleViewHeight, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - self.titleViewHeight - self.navHeight)
        
         scrollView.contentSize = CGSize.init(width: UIScreen.main.bounds.size.width * CGFloat(self.titleArray.count), height: UIScreen.main.bounds.size.height - self.titleViewHeight - self.navHeight);
        
        scrollView.backgroundColor = UIColor.clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        return scrollView
    }()
    
    fileprivate lazy var titleScrollView:FJTitleScrollView = {
        
        let titleScrollView = FJTitleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:self.titleViewHeight), titleArray: self.titleArray)
        
        titleScrollView.backgroundColor = self.configure.TitleScrollBackGroundColor
        
        titleScrollView.showsVerticalScrollIndicator = false
        return titleScrollView
    }()
    
    init(frame: CGRect,titleArray:[String]) {
        super.init(frame: frame)
        self.titleArray = titleArray
        self.configure = FJConfigure()
        self.titleViewHeight = self.configure.titleHeight + self.configure.indicatorHeight + self.padding
        self.buttonArray = self.titleScrollView.buttonArray
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FJContentView {
    
    func setupUI() -> Void {
        
        addSubview(titleScrollView)
        
        addSubview(scrollView)
         //承载子控制器的视图滚动到正确控制器位置
        titleScrollView.titleViewSelectIdxHandler = { [weak self] (selectIdx:Int) in
            self?.scrollView.contentOffset = CGPoint.init(x: CGFloat(selectIdx) * UIScreen.main.bounds.width, y: 0)
        }
        
    }
     //承载子控制器的视图与标题视图滚动到相应的位置
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            let idx = scrollView.contentOffset.x / UIScreen.main.bounds.width
            titleScrollView.titleButtonClick(button: buttonArray[Int(idx)])
            scrollView.contentOffset = CGPoint.init(x: idx * UIScreen.main.bounds.width , y: 0)
        }
    }
    
}












