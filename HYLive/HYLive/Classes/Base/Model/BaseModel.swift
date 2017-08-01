//
//  BaseModel.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/8/1.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class BaseModel: NSObject {

    override init() {
        
    }
    
    init(dict: [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
