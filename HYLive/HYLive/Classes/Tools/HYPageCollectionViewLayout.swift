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
    fileprivate lazy var totalWidth: CGFloat = 0
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
        let height: CGFloat = (collectionView.bounds.height - sectionInset.top - sectionInset.bottom - (CGFloat(row - 1) * linePading)) / CGFloat(row)
        var previousNumberOfPage = 0
        
        for s in 0..<sections {
            
            // 2. 获取每一组有多少item
            let items = collectionView.numberOfItems(inSection: s)
            for i in 0..<items {
            
                // 3.创建indexPath
                let indexPath = IndexPath(item: i, section: s)
                // 4.创建attribute
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                // 5.计算frame
                let currentPage = i / (column * row)
                let currentIndex = i % (column * row)
                let x: CGFloat = sectionInset.left + (width + itemPading) * CGFloat(currentIndex % column) + collectionView.bounds.width * CGFloat(previousNumberOfPage + currentPage)
                let y: CGFloat = sectionInset.top + CGFloat(currentIndex / column) * (height + linePading)
                
                attribute.frame = CGRect(x: x, y: y, width: width, height: height)
                
                // 6.保存attribute
                attributes.append(attribute)
            }
            
            // 7. 计算完一组, 更新页数的值
            previousNumberOfPage += (items - 1) / (column * row) + 1
        }
        
        // 8. 计算总宽度
        totalWidth = CGFloat(previousNumberOfPage) * collectionView.bounds.width
    }
}

extension HYPageCollectionViewLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

extension HYPageCollectionViewLayout {

    override var collectionViewContentSize: CGSize {
        
        return CGSize(width: totalWidth, height: 0)
    }
}
