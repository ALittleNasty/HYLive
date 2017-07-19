//
//  HYPageCollectionViewLayout.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/19.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HYPageCollectionViewLayout: UICollectionViewLayout {

    public var sectionInset: UIEdgeInsets = .zero // 上下左右间距
    public var itemPading: CGFloat = 0  // item之间间距
    public var linePading: CGFloat = 0  // item的行间距
    public var column: Int = 4 // 列数
    public var row: Int = 2    // 行数
    
    fileprivate lazy var attributes: [UICollectionViewLayoutAttributes] =  [UICollectionViewLayoutAttributes]()
    
}

extension HYPageCollectionViewLayout {

    override func prepare() {
        super.prepare()
        
        // 0. 校验collectionView
        guard let collectionView = collectionView else { return }
        
        
        
        // 1. 获取有多少组
        let sections = collectionView.numberOfSections
        
        // 2.0
        let width: CGFloat = (collectionView.bounds.width - sectionInset.left - sectionInset.right - (CGFloat(column - 1) * itemPading)) / CGFloat(column)
        let height: CGFloat = (collectionView.bounds.height - sectionInset.top - sectionInset.bottom - (CGFloat(row - 1) * itemPading)) / CGFloat(row)
        var currentRow: Int = 0
        
        for section in 0..<sections {
            
            // 2. 获取每一组有多少item
            let items = collectionView.numberOfItems(inSection: section)
            for item in 0..<items {
            
                // 3.创建indexPath
                let indexPath = IndexPath(item: item, section: section)
                // 4.创建attribute
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                // 5.计算frame
                var x: CGFloat = sectionInset.left + CGFloat(item % column) * (width + itemPading)
                
                if x + width > collectionView.bounds.width - sectionInset.right {
                    x = sectionInset.left
                    currentRow += 1
                }
                
                x = x + collectionView.bounds.width * CGFloat(section)
                let y: CGFloat = sectionInset.top + CGFloat(item / column) * (height + linePading)
                
                
                attribute.frame = CGRect(x: x, y: y, width: width, height: height)
                
                // 6.保存attribute
                attributes.append(attribute)
            }
        }
        
    }
}

extension HYPageCollectionViewLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

extension HYPageCollectionViewLayout {

    override var collectionViewContentSize: CGSize {
        
        guard let collectionView = collectionView else {
            fatalError("This layout must has a UICollectionView")
        }
        
        return CGSize(width: CGFloat(column) * collectionView.bounds.width, height: collectionView.bounds.height)
    }
}
