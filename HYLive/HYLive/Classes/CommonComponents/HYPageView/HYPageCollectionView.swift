//
//  HYPageCollectionView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/18.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//
 
import UIKit

private let kCollectionViewCellID = "kCollectionViewCellID"

protocol HYPageCollectionViewDataSource: class {
    
    // 总共多少组cell
    func numberOfSectionInPageCollectionView(_ pageCollectionView: HYPageCollectionView) -> Int
    
    // 每一组有多少个cell
    func pageCollectionView(_ pageCollectionView: HYPageCollectionView, numberOfItemsInSection section: Int) -> Int
    
    // 每个cell是什么
    func pageCollectionView(_ pageCollectionView: HYPageCollectionView, _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

class HYPageCollectionView: UIView {

    weak var dataSource : HYPageCollectionViewDataSource?
    
    fileprivate var layout: HYPageCollectionViewLayout
    fileprivate var titles : [String]
    fileprivate var style : HYPageStyle
    fileprivate var collectionView: UICollectionView!
    
    init(frame: CGRect, titles: [String], style: HYPageStyle, layout: HYPageCollectionViewLayout) {
        self.titles = titles
        self.style = style
        self.layout = layout
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
        let titleViewY = style.isTitleOnTop ? 0 : bounds.height - style.titleHeight
        let titleViewFrame = CGRect(x: 0, y: titleViewY, width: bounds.width, height: style.titleHeight)
        let titleView = HYTitleView(frame: titleViewFrame, titles: titles, style: style)
        titleView.backgroundColor = UIColor.randomColor()
        titleView.delegate = self
        addSubview(titleView)
        
        // 2. collectionView
        let collectionY = style.isTitleOnTop ? style.titleHeight : 0
        let collectionFrame = CGRect(x: 0, y: collectionY, width: bounds.width, height: bounds.height - style.titleHeight - style.pageControlHeight)
        
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionViewCellID)
        addSubview(collectionView)
        self.collectionView = collectionView
        
        // 3. pageControl
        let pageFrame = CGRect(x: 0, y: collectionFrame.maxY, width: bounds.width, height: style.pageControlHeight)
        let pageControl = UIPageControl(frame: pageFrame)
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = UIColor.randomColor()
        addSubview(pageControl)
    }
}

extension HYPageCollectionView {

    public func registerCell(_ cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    public func registerNib(_ nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
}

extension HYPageCollectionView : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSectionInPageCollectionView(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return dataSource?.pageCollectionView(self, numberOfItemsInSection: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 直接强制解包, 假如dataSource == nil, 那么上面两个方法返回均为0, 也就不会调用此方法, 故此处强制解包是安全的
        return dataSource!.pageCollectionView(self, collectionView, cellForItemAt: indexPath)
    }
}

extension HYPageCollectionView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.section) ---- \(indexPath.item)")
    }
}

extension HYPageCollectionView : HYTitleViewDelegate {
    
    func titleView(_ titleView: HYTitleView, targetIndex: Int) {
        // 获取索引
        let indexPath = IndexPath(item: 0, section: targetIndex)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}

