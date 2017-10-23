//
//  FJTitleScrollView.swift
//  Swift新闻标题
//
//  Created by webplus on 17/10/20.
//  Copyright © 2017年 sanyi. All rights reserved.
//

import UIKit
//选中标题的回调，使页面跳到正确的位置
typealias titleScrollViewSelectIdxHandler = (_ selectIdx:Int) -> Void

class FJTitleScrollView: UIScrollView {
    
    var titleArray:[String]!
    var buttonArray:[UIButton]! = Array()
    fileprivate var configure:FJConfigure!
    fileprivate var space:CGFloat!
    fileprivate let tagers = 100
    var titleViewSelectIdxHandler: titleScrollViewSelectIdxHandler?
    
    
    fileprivate lazy var indicatorView:UIView = {
        let indicatorView = UIView.init()
        indicatorView.frame = CGRect.init(x: self.space, y: self.configure.titleHeight, width: self.configure.indicatorWidth, height: self.configure.indicatorHeight)
    
        indicatorView.backgroundColor = self.configure.IndicatorColor
        
        return indicatorView
    }()

    init(frame: CGRect, titleArray:[String]) {
        super.init(frame: frame)
        self.titleArray = titleArray
        self.configure = FJConfigure()
        space = (configure.titleWidth - configure.indicatorWidth) / 2
        let fabSpace = space > 0 ? 0 : fabs(space)
        self.contentSize = CGSize.init(width:fabSpace * 2 + CGFloat(titleArray.count) * configure.titleWidth, height: 0)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FJTitleScrollView {
    //设置标题按钮与指示器
    fileprivate func setupUI() -> Void {
        
        for idx in 0 ..< titleArray.count {
           
            let titleButton = UIButton.init()
            titleButton.setTitle(titleArray[idx], for: UIControlState.normal)
            titleButton.setTitleColor(configure.TitleNormalColor, for: UIControlState.normal)
            titleButton.setTitleColor(configure.TitleSelectColor, for: UIControlState.selected)
            titleButton.titleLabel?.font = UIFont.systemFont(ofSize: configure.titleFontSize)
            titleButton.titleLabel?.textAlignment = NSTextAlignment.center;
            titleButton.tag = idx + tagers
             let fabSpace = space > 0 ? 0 : fabs(space)
            titleButton.frame = CGRect.init(x: fabSpace + CGFloat(idx) * configure.titleWidth, y: 0, width: configure.titleWidth, height: configure.titleHeight)
            titleButton.backgroundColor = UIColor.clear
            titleButton.addTarget(self, action: #selector(titleButtonClick(button:)), for: UIControlEvents.touchUpInside)
            buttonArray.append(titleButton)
            addSubview(titleButton)
            if idx == configure.titleDefaultSelect {
                titleButton.isSelected = true
                if configure.titleScale == true {
                    titleButton.transform = CGAffineTransform.init(scaleX: 1 + configure.titleScaleRange, y: 1 + configure.titleScaleRange)
                }
            }
        }
        addSubview(indicatorView)
        
        
        if configure.indicatorShow == true {
            self.indicatorView.isHidden = false;
        }else{
            self.indicatorView.isHidden = true;
        }

    }
    
    //标题点击后滚动到的位置
    func titleButtonClick(button:UIButton) -> Void {
       
        let idx:Int = button.tag - tagers
        
        for btn in buttonArray {
            if button.tag == btn.tag {
                btn.isSelected = true
                if configure.titleScale == true {
                    btn.transform = CGAffineTransform.init(scaleX: 1 + configure.titleScaleRange, y: 1 + configure.titleScaleRange)
                }
                
               var contentOffsetX:CGFloat = button.center.x - UIScreen.main.bounds.size.width * 0.5;
               let contentOffsetMax:CGFloat = self.contentSize.width - UIScreen.main.bounds.size.width;
                 contentOffsetX = contentOffsetX < 0 ? 0 : contentOffsetX;
                 contentOffsetX = contentOffsetX > contentOffsetMax ? contentOffsetMax :contentOffsetX;
                
                UIView.animate(withDuration: TimeInterval(configure.titleScrollViewAmimationTime), animations: {
                     self.contentOffset = CGPoint.init(x: contentOffsetX, y: 0)
    
                })
               
                UIView.animate(withDuration: TimeInterval(configure.indicatorAmimationTime), animations: {
                    self.indicatorView.frame = CGRect.init(x: self.space + CGFloat(idx) * self.configure.titleWidth, y: self.configure.titleHeight, width: self.configure.indicatorWidth, height: self.configure.indicatorHeight)
                });
                
                titleViewSelectIdxHandler!(idx)
                
            }else{
                btn.isSelected = false
                if configure.titleScale == true {
                    btn.transform = CGAffineTransform.identity
                }
            }
        }
    }
}
