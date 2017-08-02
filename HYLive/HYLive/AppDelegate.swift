//
//  AppDelegate.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/26.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        window?.rootViewController = MainViewController()
        
        // 全局设置状态栏的风格
        UIApplication.shared.statusBarStyle = .lightContent
        
        return true
    } 
}

