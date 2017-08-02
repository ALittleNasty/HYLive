//
//  Emitterable.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/8/2.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
/**
 *  控制器发射粒子效果的协议
 */

import UIKit

protocol Emitterable {
    
}

extension Emitterable where Self : UIViewController {

    func satrtEmitter(at position: CGPoint, with contentImageName: String) {
    
        // 1.创建发射器
        let emitter = CAEmitterLayer()
        
        // 2.设置发射器位置
        emitter.emitterPosition = position
        
        // 3.开启三维效果
        emitter.preservesDepth = true
        
        // 4.创建粒子, 并设置相关属性
        var cells = [CAEmitterCell]()
        for _ in 0..<10 {
            
            // 4.1.创建粒子
            let cell = CAEmitterCell()
            
            // 4.2.设置速度
            cell.velocity = 150
            cell.velocityRange = 100
            
            // 4.3.设置缩放大小
            cell.scale = 0.7
            cell.scaleRange = 0.3
            
            // 4.4.设置粒子方向
            cell.emissionLongitude = CGFloat(-Double.pi * 0.5)
            cell.emissionRange = CGFloat(Double.pi / 12)
            
            // 4.5.设置生命周期
            cell.lifetime = 3
            cell.lifetimeRange = 1.5
            
            // 4.6.设置旋转角度
            cell.spin = CGFloat(-Double.pi * 0.5)
            cell.spinRange = CGFloat(Double.pi * 0.25)
            
            // 4.7.设置粒子每秒弹出的个数
            cell.birthRate = 2
            
            // 4.8.设置粒子真是的图片
            cell.contents = UIImage(named: contentImageName)?.cgImage
            
            // 4.9.添加到数组
            cells.append(cell)
        }
        
        // 5.将粒子设置到发射器中
        emitter.emitterCells = cells
        
        // 6.添加到layer上
        view.layer.addSublayer(emitter)
    }
    
    func stopEmittering() {
    
        /*
        for layer in view.layer.sublayers! {
            if layer.isKind(of: CAEmitterLayer.self) {
                layer.removeFromSuperlayer()
            }
        } 
        */
        
        view.layer.sublayers?.filter({$0.isKind(of: CAEmitterLayer.self)}).first?.removeFromSuperlayer()
    }
}
