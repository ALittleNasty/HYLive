//
//  HYContentView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/27.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HYContentView: UIView {

    // MARK: - 属性
    var chileVCs: [UIViewController]
    var parentVC: UIViewController
    
    
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController) {
        self.chileVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
