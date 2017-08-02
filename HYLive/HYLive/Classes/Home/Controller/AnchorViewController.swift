//
//  AnchorViewController.swift
//  HYLive
//
//  Created by 胡阳 on 2017/8/1.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit
import SnapKit

class AnchorViewController: UIViewController {
    
    public var type: Int = 0
    
    fileprivate var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        testLabel = UILabel(frame: view.bounds)
        testLabel.textAlignment = .center
        testLabel.font = UIFont.systemFont(ofSize: 30)
        testLabel.textColor = .black
        testLabel.text = "\(type)"
        testLabel.backgroundColor = .white
        view.addSubview(testLabel)
        testLabel.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        
        view.backgroundColor = UIColor.randomColor()
        
        
    } 

}
