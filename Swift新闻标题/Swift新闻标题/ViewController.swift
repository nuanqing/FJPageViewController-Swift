//
//  ViewController.swift
//  Swift新闻标题
//
//  Created by webplus on 17/10/20.
//  Copyright © 2017年 sanyi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var titleScrollView:FJTitleScrollView?
    var contentView:FJContentView!
    fileprivate var configure = FJConfigure()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "导航"
        self.navigationController?.navigationBar.isTranslucent = false
        
        let titleArray = ["测试01","测试02","测试03","测试04","测试05","测试06","测试07","测试08","测试09","测试10"]
        
        
        contentView = FJContentView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), titleArray: titleArray)
        contentView.backgroundColor = UIColor.clear
        self.view.addSubview(contentView)
        
        for idx in 0 ..< titleArray.count {
            let vc = UIViewController()
            vc.view.frame = CGRect.init(x: UIScreen.main.bounds.size.width * CGFloat(idx), y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random()%256)/255.0 , green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
            contentView.scrollView.addSubview(vc.view)
            addChildViewController(vc)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

