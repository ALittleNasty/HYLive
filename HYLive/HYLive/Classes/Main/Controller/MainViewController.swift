//
//  MainViewController.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/8/1.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

private let titleNormalColor = UIColor.black
private let titleSelectedColor = UIColor(r: 191, g: 138, b: 82)

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 添加子视图控制器
        addChildVC()
    }

    fileprivate func addChildVC() {
        
        let normalAttribute = [NSForegroundColorAttributeName : titleNormalColor]
        let selectedAttribute = [NSForegroundColorAttributeName : titleSelectedColor]
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named:"live-n"), selectedImage: UIImage(named:"live-p"))
        homeVC.tabBarItem.setTitleTextAttributes(normalAttribute, for: .normal)
        homeVC.tabBarItem.setTitleTextAttributes(selectedAttribute, for: .selected)
        let homeNavi = HYNavigationController(rootViewController: homeVC)
        
        
        let rankVC = RankViewController()
        rankVC.tabBarItem = UITabBarItem(title: "排行", image: UIImage(named:"ranking-n"), selectedImage: UIImage(named:"ranking-p"))
        rankVC.tabBarItem.setTitleTextAttributes(normalAttribute, for: .normal)
        rankVC.tabBarItem.setTitleTextAttributes(selectedAttribute, for: .selected)
        
        let discoveryVC = DiscoveryViewController()
        discoveryVC.tabBarItem = UITabBarItem(title: "发现", image: UIImage(named:"found-n"), selectedImage: UIImage(named:"found-p"))
        discoveryVC.tabBarItem.setTitleTextAttributes(normalAttribute, for: .normal)
        discoveryVC.tabBarItem.setTitleTextAttributes(selectedAttribute, for: .selected)
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = UITabBarItem(title: "我", image: UIImage(named:"mine-n"), selectedImage: UIImage(named:"mine-p"))
        profileVC.tabBarItem.setTitleTextAttributes(normalAttribute, for: .normal)
        profileVC.tabBarItem.setTitleTextAttributes(selectedAttribute, for: .selected)
        
        viewControllers = [homeNavi, rankVC, discoveryVC, profileVC]
        
        tabBar.barTintColor = UIColor.white
    }
}
