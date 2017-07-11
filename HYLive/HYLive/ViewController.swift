//
//  ViewController.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/26.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        automaticallyAdjustsScrollViewInsets = false 
                
        // 创建pageView
        // 1.获取frame
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 2.标题
        let titles: [String] = ["推荐", "王者农药", "娱乐", "使命召唤", "游戏", "英雄联盟", "星际争霸", "手游", "穿越火线", "生化危机"]
        
        // 3.显示的风格
        let style = HYPageStyle()
        style.isTitleViewScrollEnable = true
        style.isNeedTitleScale = true
        
        // 4.获取pageview中所有的内容控制器
        var childVCs: [UIViewController] = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVCs.append(vc)
        }
        
        // 5.获取父控制器(self)
        
        let pageView = HYPageView(frame: frame, titles: titles, style: style, childVCs: childVCs, parentVC: self)
        view.addSubview(pageView)
    }
    
}

/*
 func guardAndIfLetUsage() {
 if let url = URL(string: "https://www.baidu.com") {
 let req = NSURLRequest(url: url)
 print(req)
 }
 
 let dict: [String: Any] = ["name": "huyang", "age": 26, "height": 1.88]
 
 dealDict(dict: dict)
 }
 
 func dealDict(dict: [String: Any]) {
 // 分别取出name, age, height
 
 /* 垃圾代码
 if let name = dict["name"] as? String {
 print(name)
 
 if let age = dict["age"] as? Int {
 print(age)
 
 if let height = dict["height"] as? Double {
 print(height)
 }
 }
 }
 */
 
 guard let name = dict["name"] as? String else {
 return
 }
 print(name)
 
 guard let age = dict["age"] as? Int else {
 return
 }
 print(age)
 
 guard let height = dict["height"] as? Double else {
 return
 }
 print(height)
 }
 
 */
