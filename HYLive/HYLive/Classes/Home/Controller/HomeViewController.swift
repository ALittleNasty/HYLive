//
//  HomeViewController.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/8/1.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.cyan
        setupUI()
    }
}

// MARK: - 设置UI
extension HomeViewController {

    fileprivate func setupUI() {
    
        setupNavigationBar()
        setupContentView()
    }
    
    fileprivate func setupNavigationBar() {
    
        navigationController?.navigationBar.barTintColor = UIColor.black.withAlphaComponent(0.3)
        
        let logoImg = UIImage(named: "home-logo")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logoImg, style: .plain, target: nil, action: nil)
        
        let collectImg = UIImage(named: "search_btn_follow")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: collectImg, style: .plain, target: self, action: #selector(collectItemAction))
        
        let searchFrame = CGRect(x: 0, y: 0, width: 200, height: 32)
        let searchBar = UISearchBar(frame: searchFrame)
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .default
        searchBar.isUserInteractionEnabled = false
        
        let searchField = searchBar.value(forKey: "_searchField") as! UITextField
        searchField.textColor = .white
        navigationItem.titleView = searchBar
    }
    
    fileprivate func setupContentView() {
        
        let homeTypes = loadHomeTypeData()
        
        let style = HYPageStyle()
        style.isTitleViewScrollEnable = true
        style.isShowBottomLine = true
        
        let height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight
        let frame = CGRect(x: 0, y: kNavigationBarHeight + kStatusBarHeight, width: kScreenWidth, height: height)
        
        let titles = homeTypes.map({$0.title})
        
        var childVCs = [AnchorViewController]()
        for type in homeTypes {
            let anchorVC = AnchorViewController()
            anchorVC.type = type
            childVCs.append(anchorVC)
        }
        
        let pageView = HYPageView(frame: frame, titles: titles, style: style, childVCs: childVCs, parentVC: self)
        view.addSubview(pageView)
    }
    
    fileprivate func loadHomeTypeData() -> [HomeType] {
    
        let path = Bundle.main.path(forResource: "types", ofType: "plist")!
        let rowData = NSArray(contentsOfFile: path) as! [[String : Any]]
        var types = [HomeType]()
        for dict in rowData {
            types.append(HomeType(dict: dict))
        }
        return types
    }
}

// MARK: - 事件处理
extension HomeViewController {

    @objc fileprivate func collectItemAction() {
        print("点击了收藏按钮")
    }
}
