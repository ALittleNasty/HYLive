//
//  AnchorViewController.swift
//  HYLive
//
//  Created by 胡阳 on 2017/8/1.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit
import SnapKit

private let padding : CGFloat = 8
private let anchorCellID = "anchorCellIdentifier"

class AnchorViewController: UIViewController {
    
    // MARK: - 公开属性type
    public var type: HomeType!
    
    fileprivate lazy var homeVM : HomeViewModel = HomeViewModel()
    fileprivate lazy var collectionView : UICollectionView = {
    
        let layout = HYWaterfallLayout()
        layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding)
        layout.minimumLineSpacing = padding
        layout.minimumInteritemSpacing = padding
        layout.dataSource = self
        
        let height = kScreenHeight - kNavigationBarHeight - kStatusBarHeight - kTabBarHeight - 44.0
        let frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: height)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout:layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "HomeViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: anchorCellID)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        loadData(index: 0)
    }
}

// MARK: - Util
extension AnchorViewController {

    // MARK: - 加载数据
    fileprivate func loadData(index: Int) {
    
        homeVM.loadHomeData(type: type, index: index) { 
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension AnchorViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did selected an index \(indexPath.item)")
    }
}

// MARK: - UICollectionViewDataSource
extension AnchorViewController : UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.anchorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: anchorCellID, for: indexPath) as! HomeViewCell
        
        cell.anchorModel = homeVM.anchorModels[indexPath.item]
        if indexPath.item == homeVM.anchorModels.count - 1 {
            loadData(index: homeVM.anchorModels.count)
        }
        
        return cell
    }
}

// MARK: - HYWaterfallLayoutDataSource
extension AnchorViewController : HYWaterfallLayoutDataSource {

    func waterfallLayout(_ layout: HYWaterfallLayout, atItemIndex: Int) -> CGFloat {
        return atItemIndex % 2 == 0 ? kScreenWidth * 2 / 3 : kScreenWidth * 0.5
    }
}
