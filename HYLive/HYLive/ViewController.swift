//
//  ViewController.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/26.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

private let kCollectionViewCellID = "kCollectionViewCellID"

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        automaticallyAdjustsScrollViewInsets = false 
                
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: 180)
        let style = HYPageStyle()
        style.isTitleViewScrollEnable = false
        style.isShowBottomLine = true
        
        let layout = HYPageCollectionViewLayout()
        layout.linePading = 10
        layout.itemPading = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.column = 4
        layout.row = 2
        
        let titles = ["热门", "豪华", "专属", "高级"]
        let pageCollectionView = HYPageCollectionView(frame: frame, titles: titles, style: style, layout: layout)
        pageCollectionView.dataSource = self
        pageCollectionView.registerCell(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellID)
        view.addSubview(pageCollectionView)
        
//        setupPageView()
        
        setupNavagationBar()
    }
    
    private func setupPageView() {
    
        // 创建pageView
        // 1.获取frame
        let frame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        // 2.标题
        let titles: [String] =  ["推荐", "王者农药", "娱乐", "使命召唤"]
            //["推荐", "王者农药", "娱乐", "使命召唤", "游戏", "英雄联盟", "星际争霸", "手游", "穿越火线", "生化危机"]
        
        // 3.显示的风格
        let style = HYPageStyle()
        style.isTitleViewScrollEnable = false
        style.isNeedTitleScale = false
        style.isShowBottomLine = true
        
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
    
    private func setupNavagationBar() {
    
        let nextItem = UIBarButtonItem(title: "NEXT", style: .plain, target: self, action: #selector(nextAction))
        navigationItem.rightBarButtonItem = nextItem
    }
    
    @objc private func nextAction() {
        let waterFallVC = WaterFallViewController()
        navigationController?.pushViewController(waterFallVC, animated: true)
    }
    
}

extension ViewController: HYPageCollectionViewDataSource {

    func pageCollectionView(_ pageCollectionView: HYPageCollectionView, numberOfItemsInSection section: Int) -> Int {
        let couns = [12, 20, 3, 6]
        return couns[section]
    }
    
    func numberOfSectionInPageCollectionView(_ pageCollectionView: HYPageCollectionView) -> Int {
        return 4
    }
    
    func pageCollectionView(_ pageCollectionView: HYPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
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
