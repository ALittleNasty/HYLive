//
//  ViewController.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/26.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let url = URL(string: "https://www.baiud.com") {
            let req = NSURLRequest(url: url)
            print(req)
        }
        
        let dict: [String: Any] = ["name": "huyang", "age": 26, "height": 1.88]
        
        dealDict(dict: dict)
    }
    
    func dealDict(dict: [String: Any]) {
        // 分别取出name, age, height
        
        /* 垃圾代码
        if let name = dict["name"] as? String {
            print(name)
            
            if let age = dict["age"] as? Int {
                print(age)
                
                if let height = dict["height"] as? Double {
                    print(height)
                }
            }
        }
        */
        
        guard let name = dict["name"] as? String else {
            return
        }
        print(name)
        
        guard let age = dict["age"] as? Int else {
            return
        }
        print(age)
        
        guard let height = dict["height"] as? Double else {
            return
        }
        print(height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

