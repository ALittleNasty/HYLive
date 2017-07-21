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

    weak var dataSource : HYPageCollectionViewDataSource? {
        didSet {
            let firstSectionItemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: 0) ?? 0
//            pageControl.numberOfPages = (firstSectionItemCount - 1) / (layout.column * layout.row) + 1
            pageControl.numberOfPages = calculatePage(firstSectionItemCount, fullPageCount: layout.column * layout.row)
        }
    }
    
    fileprivate var layout: HYPageCollectionViewLayout
    fileprivate var titles : [String]
    fileprivate var style : HYPageStyle
    fileprivate var collectionView: UICollectionView!
    fileprivate var pageControl: UIPageControl!
    fileprivate var titleView: HYTitleView!
    fileprivate lazy var currentIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
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
        self.titleView = titleView
        
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
        pageControl.numberOfPages = 1
        pageControl.backgroundColor = UIColor.randomColor()
        pageControl.hidesForSinglePage = false
        addSubview(pageControl)
        self.pageControl = pageControl
    }
    
    
    fileprivate func calculatePage(_ itemCount: Int, fullPageCount: Int) -> Int {
        
        if (itemCount % fullPageCount) == 0 {
            return (itemCount / fullPageCount == 0) ? 1 : itemCount / fullPageCount
        } else {
            return (itemCount / fullPageCount == 0) ? 1 : itemCount / fullPageCount + 1
        }
    }
}

// MARK: - 暴露给外面的方法 (注册cell, 刷新数据)
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

// MARK: - UICollectionViewDataSource
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

// MARK: - UICollectionViewDelegate
extension HYPageCollectionView: UICollectionViewDelegate {

    // 停止减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    
    // 停止拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // 没有减速, 完全是手指拖拽停止的
        if !decelerate {
            scrollViewEndScroll()
        }
    }
    
    private func scrollViewEndScroll() {
    
        // 1. 获取滚动位置对应的indexPath
        let point = CGPoint(x: layout.sectionInset.left + 1 + collectionView.contentOffset.x, y: layout.sectionInset.top + 1)
        
        guard let indexPath = collectionView.indexPathForItem(at: point) else { return }
        
        
        let itemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: indexPath.section) ?? 0
        // 2. 判断是否需要改变组
        if indexPath.section != currentIndexPath.section {  // 组改变
            
            // 2.1 改变pageControl
            pageControl.numberOfPages = calculatePage(itemCount, fullPageCount: layout.row * layout.column)
            pageControl.currentPage = indexPath.item / (layout.row * layout.column)
            
            // 2.2 记录最新的IndexPath
            currentIndexPath = indexPath
            
            // 2.3 改变titleView
            titleView.setCurrent(indexPath.section)
        } else {                                            // 组没有改变
            // 2.1 改变pageControl
//            pageControl.numberOfPages = calculatePage(itemCount, fullPageCount: layout.row * layout.column)
            pageControl.currentPage = indexPath.item / (layout.row * layout.column)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.section) ---- \(indexPath.item)")
    }
}

// MARK: - HYTitleViewDelegate (title点击事件代理)
extension HYPageCollectionView : HYTitleViewDelegate {
    
    func titleView(_ titleView: HYTitleView, targetIndex: Int) {
        // 1.获取索引
        let indexPath = IndexPath(item: 0, section: targetIndex)
        
        // 2.滚动到指定的索引位置
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        // 3.调整滚动位置
        let lastPageItemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: targetIndex) ?? 0
        let fullPageItemCount = layout.column * layout.row
        let isLastPageOnlyOneScreen = lastPageItemCount <= fullPageItemCount ? true : false
        
        if (targetIndex == titles.count - 1) && isLastPageOnlyOneScreen {
            // 最后一组只显示1页的时候不做偏移
            return
        }
        collectionView.contentOffset.x -= layout.sectionInset.left
        
        // 4.修改pageControl的小圆点个数
        let sectionItemCount = dataSource?.pageCollectionView(self, numberOfItemsInSection: targetIndex) ?? 0
//        pageControl.numberOfPages = (sectionItemCount - 1) / fullPageItemCount + 1
        pageControl.numberOfPages = calculatePage(sectionItemCount, fullPageCount: fullPageItemCount)
        pageControl.currentPage = 0
        
        // 5.记录当前IndexPath
        currentIndexPath = indexPath
    }
}

