//
//  HYTitleView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/27.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HYTitleView: UIView {

    // MARK: - 属性
    var titles: [String]
    var style: HYPageStyle
    
    
    init(frame: CGRect, titles: [String], style: HYPageStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
