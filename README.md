# FJPageViewController-Swift
Swift版本

>作者：nuanqing
>
>版本：1.0.0
>
>简介：类似网易新闻，腾讯视频，今日头条等标题的滚动效果控件，可以自己定义效果。
>


![效果图](https://github.com/nuanqing/FJPageViewController/blob/master/类似网易新闻标题/pageView.png)


基本使用，在控制器中添加以下代码:

```
        let titleArray = ["测试01","测试02","测试03","测试04","测试05","测试06","测试07","测试08","测试09","测试10"]
        //初始化
        contentView = FJContentView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), titleArray: titleArray)
        contentView.backgroundColor = UIColor.clear
        self.view.addSubview(contentView)
        //添加子控制器
        for idx in 0 ..< titleArray.count {
            let vc = UIViewController()
            vc.view.frame = CGRect.init(x: UIScreen.main.bounds.size.width * CGFloat(idx), y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random()%256)/255.0 , green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
            contentView.scrollView.addSubview(vc.view)
            addChildViewController(vc)
        }

```
修改配置:

```
 //标题宽度
     let titleWidth:CGFloat = 100
    //标题高度
     let titleHeight:CGFloat = 40
    //选中标题的放大效果
     let titleScale:Bool = true
    //标题放大范围 0 - 1
     let titleScaleRange:CGFloat = 0.3
    //标题字的大小
     let titleFontSize:CGFloat = 16
    //是否显示指示器
     let indicatorShow:Bool = true
    //指示器宽度
     let indicatorWidth:CGFloat = 120
    //指示器高度
     let indicatorHeight:CGFloat = 4
    //指示器过渡动画时间
     let indicatorAmimationTime:CGFloat = 0.2
    //标题过渡动画时间
    let titleScrollViewAmimationTime:CGFloat = 0.32
    //标题颜色
     let TitleNormalColor:UIColor = UIColor.black
    //标题选中颜色
     let TitleSelectColor:UIColor = UIColor.blue
    //标题背景色
    let TitleScrollBackGroundColor:UIColor = UIColor.darkGray
    //指示器颜色
     let IndicatorColor:UIColor = UIColor.gray
    //标题的默认选中 (不能超过数组的个数)
    let titleDefaultSelect:Int  = 0;
```

有用的话，不妨给个**Star**吧！~
