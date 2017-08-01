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
        
    }
    
    @objc fileprivate func collectItemAction() {
        print("点击了收藏按钮")
    }
}
