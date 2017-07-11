//
//  HYPageView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/27.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HYPageView: UIView {

    // MARK: - 属性
    var titles: [String]
    var style: HYPageStyle
    var childVCs: [UIViewController]
    var parentVC: UIViewController
    
    // MARK: - 构造函数
    init(frame: CGRect, titles: [String], style: HYPageStyle, childVCs: [UIViewController], parentVC: UIViewController) {
        // 初始化属性
        self.titles = titles
        self.style = style
        self.childVCs = childVCs
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        setupUI()
    }

    // required修饰的函数
    // 如果子类有重新/自定义其他的构造函数, 那么必须使用required修饰构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 设置UI界面
extension HYPageView {

    fileprivate func setupUI() {
        // 1.添加titleView
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeight)
        let titleView = HYTitleView(frame: titleFrame, titles: titles, style: style)
        titleView.backgroundColor = UIColor.cyan
        addSubview(titleView)
        
        // 2.添加contentView
        let contentFrame = CGRect(x: 0, y: titleFrame.maxY, width: bounds.width, height: bounds.height - style.titleHeight)
        let contentView = HYContentView(frame: contentFrame, childVCs: childVCs, parentVC: parentVC)
        contentView.backgroundColor = UIColor.cyan
        addSubview(contentView)
        
        // 3.让titleView和contentView联动
        titleView.delegate = contentView
        contentView.delegate = titleView
    }
}
