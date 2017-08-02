//
//  NibLoadable.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/8/2.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
/**
 *  从Xib加载UIView的协议
 */

import Foundation
import UIKit

protocol NibLoadable {
    
}

extension NibLoadable where Self : UIView {

    static func loadFromNib(_ nibName: String? = nil) -> Self {
    
        let name = nibName == nil ? "\(self)" : nibName!
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as! Self
    }
}
