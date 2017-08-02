//
//  HYContentView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/27.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellIdentifier"

protocol HYContentViewDelegate: class {
    
    func contentView(_ contentView: HYContentView, didEndScroll inIndex: Int)
    
    func contentView(_ contentView: HYContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat)
}

class HYContentView: UIView {

    // MARK: - 属性
    weak var delegate: HYContentViewDelegate?
    fileprivate var isForbidDelegate: Bool = false
    fileprivate var startOffsetX: CGFloat = 0
    fileprivate var childVCs: [UIViewController]
    fileprivate var parentVC: UIViewController
    fileprivate lazy var collectionView : UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height)
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.bounces = false
        collectionView.isPagingEnabled = true
        // 点击状态栏不允许scrollView回到顶部
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    // MARK: - 构造方法
    init(frame: CGRect, childVCs: [UIViewController], parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension HYContentView {
    
    fileprivate func setupUI() {
        // 1.将childVC添加到parentVC中
        for childVC in childVCs {
            parentVC.addChildViewController(childVC)
        }
        
        // 2.添加UICollectionView
        addSubview(collectionView)
    }
}

// MARK: - UICollectionViewDelegate
extension HYContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        // 防止cell复用, 重复添加子控制器的视图, 每次cell显示的时候先移除所有子视图
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        // 重新添加当前控制器的视图
        let currentVC = childVCs[indexPath.item]
        currentVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(currentVC.view)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HYContentView: UICollectionViewDelegate {
    
    // 结束减速
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScroll()
    }
    
    // 结束拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidEndScroll()
        }
    }
    
    // 开始拖拽
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
        isForbidDelegate = false
    }
    
    // 正在滚动, 调用很多次
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 获取当前实时偏移量
        let contentOffsetX = scrollView.contentOffset.x
        // 0.先判断有没有滑动, 没有滑动直接返回 是否禁止代理事件
        guard startOffsetX != contentOffsetX && !isForbidDelegate else {
            return
        }
        
        var targetIndex: Int = 0
        var progress: CGFloat = 0
        let currentIndex = Int(startOffsetX / scrollView.bounds.width)
        
        if contentOffsetX > startOffsetX {  // 向左滑动
            targetIndex = currentIndex + 1
            // 防止越界
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            progress = (contentOffsetX - startOffsetX) / scrollView.bounds.width
            
        } else {                            // 向右滑动
            targetIndex = currentIndex - 1
            if targetIndex < 0 {
                targetIndex = 0
            }
            
            progress = (startOffsetX - contentOffsetX) / scrollView.bounds.width
        }
        
        delegate?.contentView(self, sourceIndex: currentIndex, targetIndex: targetIndex, progress: progress)
    }
    
    private func scrollViewDidEndScroll() {
        let index = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        delegate?.contentView(self, didEndScroll: index)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

// MARK: - HYTitleViewDelegate
extension HYContentView: HYTitleViewDelegate {
    
    func titleView(_ titleView: HYTitleView, targetIndex: Int) {
        
        // 0. 禁止代理
        isForbidDelegate = true
        
        // 1. 获取indexPath
        let indexPath = IndexPath(item: targetIndex, section: 0)
        
        // 根据titleView点击的index , 滚动到正确的位置
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
}
