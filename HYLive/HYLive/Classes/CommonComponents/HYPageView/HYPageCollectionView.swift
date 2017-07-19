//
//  HYPageCollectionView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/18.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

private let kCollectionViewCellID = "kCollectionViewCellID"

class HYPageCollectionView: UIView {

    fileprivate var titles : [String]
    fileprivate var isTitleOnTop: Bool
    fileprivate var style: HYPageStyle

    init(frame: CGRect, titles: [String], style: HYPageStyle, isTitleOnTop: Bool) {
        self.titles = titles
        self.isTitleOnTop = isTitleOnTop
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HYPageCollectionView {

    fileprivate func setupUI() {
    
        // 1. titleView
        let titleViewY = isTitleOnTop ? 0 : bounds.height - style.titleHeight
        let titleViewFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleHeight)
        let titleView = HYTitleView(frame: titleViewFrame, titles: titles, style: style)
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
        
        // 2. collectionView
        let collectionY = isTitleOnTop ? style.titleHeight : 0
        let collectionFrame = CGRect(x: 0, y: collectionY, width: bounds.width, height: bounds.height - style.titleHeight - style.pageControlHeight)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: bounds.width * 0.25, height: collectionFrame.height * 0.5)
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.randomColor()
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellID)
        addSubview(collectionView)
        
        // 3. pageControl
        let pageFrame = CGRect(x: 0, y: collectionFrame.maxY, width: bounds.width, height: style.pageControlHeight)
        let pageControl = UIPageControl(frame: pageFrame)
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = UIColor.randomColor()
        addSubview(pageControl)
    }
    
    
}

extension HYPageCollectionView : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.randomColor()
        
        return cell
    }
}

extension HYPageCollectionView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}


