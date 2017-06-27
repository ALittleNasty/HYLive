//
//  HYContentView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/27.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellIdentifier"

class HYContentView: UIView {

    // MARK: - 属性
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
        cell.contentView.addSubview(currentVC.view)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HYContentView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
