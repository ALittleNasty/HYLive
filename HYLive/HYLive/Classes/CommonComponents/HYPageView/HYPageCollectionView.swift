//
//  HYPageCollectionView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/18.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HYPageCollectionView: UIView {

    fileprivate var titles : [String]
    fileprivate var isTitleOnTop: Bool
    fileprivate var style: HYPageStyle

    init(frame: CGRect, titles: [String], style: HYPageStyle, isTitleOnTop: Bool) {
        self.titles = titles
        self.isTitleOnTop = isTitleOnTop
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HYPageCollectionView {

    fileprivate func setupUI() {
    
        // 1. titleView
        let titleViewY = isTitleOnTop ? 0 : bounds.height - style.titleHeight
        let titleViewFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleHeight)
        let titleView = HYTitleView(frame: titleViewFrame, titles: titles, style: style)
        addSubview(titleView)
        
        // 2. collectionView
        
        
        // 3. pageControl
        
    }
    
    
}
