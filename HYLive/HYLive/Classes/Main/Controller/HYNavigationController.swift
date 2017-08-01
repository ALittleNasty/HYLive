//
//  HYNavigationController.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/17.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HYNavigationController: UINavigationController {

    // 重写preferredStatusBarStyle这个属性, 改变状态栏为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 校验这个手势是否存在
        guard let popGesture = interactivePopGestureRecognizer else {
            return
        }
        
        /* 通过运行时机制回去所有属性
        var count: UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        print("Ivar List count: \(count)")
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let namePointer = ivar_getName(ivar)
            let name = String(cString: namePointer!)
            print(name)
        } */
        
        // action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fd947600980>
        guard let targets = popGesture.value(forKeyPath: "_targets") as? [NSObject] else {
            return
        }
        
        guard let obj = targets.first else {
            return
        }
        
        let action = Selector(("handleNavigationTransition:")) // action通过KVC获取不到, 所以只能通过它响应的方法生成一个Selector
        let target = obj.value(forKeyPath: "target")           // target可通过KVC直接获取
        
        // 创建自己的手势
        let panGesture = UIPanGestureRecognizer(target: target, action: action)
        
        view.addGestureRecognizer(panGesture)
    }
    
    
//    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
//        if view.tag != 10086 {
//            viewController.hidesBottomBarWhenPushed = true
//        }
//        super.pushViewController(viewController, animated: animated)
//    }
}
