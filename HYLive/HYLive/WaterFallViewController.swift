//
//  WaterFallViewController.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

private let kCellID = "kCellIdentifier"

class WaterFallViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, HYWaterfallLayoutDataSource{

    fileprivate lazy var collectionView: UICollectionView = {
    
        let layout = HYWaterfallLayout()
        layout.dataSource = self
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCellID)
        return collectionView
    }()
    
    var itemCount: Int = 30
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor()
        title = "瀑布流"
        
        view.addSubview(collectionView)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.bounds.height {
            itemCount += 30
            collectionView.reloadData()
        }
    }
    
    func waterfallLayout(_ layout: HYWaterfallLayout, atItemIndex: Int) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return ((atItemIndex % 2) == 0) ? screenWidth * 2/3 : screenWidth * 0.5
    }
}
