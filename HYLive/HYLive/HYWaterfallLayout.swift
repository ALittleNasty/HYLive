//
//  HYWaterfallLayout.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/14.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
/*
 
 var minHeight = sectionInset.top
 for h in heights {
 if minHeight > h {
 minHeight = h
 }
 }
 
 */

import UIKit

protocol HYWaterfallLayoutDataSource: class {
    func waterfallLayout(_ layout: HYWaterfallLayout, atItemIndex: Int) -> CGFloat
}

class HYWaterfallLayout: UICollectionViewFlowLayout {

    weak var dataSource: HYWaterfallLayoutDataSource? // 代理
    public var column: Int = 2 // 列数(默认为2列)
    fileprivate lazy var attributes: [UICollectionViewLayoutAttributes] =  [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxHeight: CGFloat = self.sectionInset.top + self.sectionInset.bottom
    fileprivate lazy var heights: [CGFloat] = Array(repeating: self.sectionInset.top, count: self.column)
}

//  实现瀑布流一般得实现三个方法
// MARK:- 1.准备所有cell的布局
extension HYWaterfallLayout {

    override func prepare() {
        
        // 0. 校验collectionView是否有值
        guard let collectionView = collectionView else { return }
        guard let dataSource = dataSource else {
            fatalError("请设置瀑布流的数据源, 否则无法完成布局")
        }
        
        // 1. 获取cell的个数
        let count = collectionView.numberOfItems(inSection: 0)
        
        // 2. 遍历所有的cell, 给每一个cell准备一个UICollectionViewLayoutAttributes
//        let column = 3 // 列数
        // 计算item宽度
        let itemWidth = (collectionView.bounds.width - sectionInset.left - sectionInset.right - CGFloat(column - 1) * minimumInteritemSpacing) / CGFloat(column)
        // Array(repeating: , count: ) 重复向数组中重复添加n个相同的元素
        
        for i in attributes.count..<count {
            
            // 获取索引, 创建对应的UICollectionViewLayoutAttributes
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 给cell设置frame
            // 计算x
            let minHeight = heights.min()!
            let minHeightIndex = heights.index(of: minHeight)!
            let itemX = sectionInset.left + (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightIndex)
            // 计算y
            let itemY = (minHeight == sectionInset.top) ? sectionInset.top : minHeight + minimumLineSpacing
            // 高度随机
            let itemHeight = dataSource.waterfallLayout(self, atItemIndex: i)
                // CGFloat(arc4random_uniform(100)) + 100.0
            attribute.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: itemHeight)
            
            // 将attribute添加到数组中
            attributes.append(attribute)
            
            // 更新minHeight的值
            heights[minHeightIndex] = attribute.frame.maxY
        }
        
        // 记录最大高度
        maxHeight = heights.max()!
    }
}

// MARK:- 2.告知系统准备好的布局
extension HYWaterfallLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}


// MARK:- 3.告知系统滚动范围(contentSize)
extension HYWaterfallLayout {
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxHeight + sectionInset.bottom)
    }
}
