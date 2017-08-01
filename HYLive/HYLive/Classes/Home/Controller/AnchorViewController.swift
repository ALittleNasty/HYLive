//
//  AnchorViewController.swift
//  HYLive
//
//  Created by 胡阳 on 2017/8/1.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class AnchorViewController: UIViewController {
    
    public var type: Int = 0

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var testLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testLabel.text = "\(type)"
        view.backgroundColor = UIColor.randomColor()
    } 

}
