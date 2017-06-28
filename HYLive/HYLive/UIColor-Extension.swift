//
//  UIColor-Extension.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/27.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    // class修饰的函数相当于OC中的 "+" 方法
    // 随机色
    class func randomColor() -> UIColor {
        let valueR = CGFloat(arc4random_uniform(256)) / 255.0
        let valueG = CGFloat(arc4random_uniform(256)) / 255.0
        let valueB = CGFloat(arc4random_uniform(256)) / 255.0
        return UIColor(red: valueR, green: valueG, blue: valueB, alpha: 1.0)
    }
    
    // a: CGFloat = 1.0 使用了swift的默认参数的属性(调用这个函数的时候这个a可以给, 也可以不给)
    // 在extension扩充构造函数, 必须扩充便利构造函数
    /*
     1> 必须在init前面加上extension关键字
     2> 必须调用self.init()的某一个构造方法
     */
    convenience init(r: CGFloat, g: CGFloat, b:CGFloat, a: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    
    // transfer Hex String to UIColor
    convenience init?(hexString: String) {
        
        // 1. 判断字符串的长度是否为大于等于6位
        guard hexString.characters.count >= 6 else {
            return nil
        }
        
        // 2. 全部转换为大写
        var hexTempStr = hexString.uppercased()
        
        // 3. 判断字符串是否以0X或者##开头
        if hexTempStr.hasPrefix("0X") || hexTempStr.hasPrefix("##") {
            hexTempStr = (hexTempStr as NSString).substring(from: 2)
        }
            // 判断字符串是否以#开头
        if hexTempStr.hasPrefix("#") {
            hexTempStr = (hexTempStr as NSString).substring(from: 1)
        }
        
        // 4. 获取rgb分别对应的16进制
        var range = NSRange(location: 0, length: 2)
        let rHex = (hexTempStr as NSString).substring(with: range)
        
        range.location += 2
        let gHex = (hexTempStr as NSString).substring(with: range)
        
        range.location += 2
        let bHex = (hexTempStr as NSString).substring(with: range)
        
        // 5. 将16进制转为具体数值
        var r: UInt32 = 0, g: UInt32 = 0,  b: UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        self.init(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
}
