//
//  WaterFallViewController.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/13.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

private let kCellID = "kCellIdentifier"

class WaterFallViewController: UIViewController , UICollectionViewDataSource, HYWaterfallLayoutDataSource{

    fileprivate lazy var collectionView: UICollectionView = {
    
        let layout = HYWaterfallLayout()
        layout.dataSource = self
        layout.column = 3
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
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
        if indexPath.item == itemCount - 1 {
            itemCount += 30;
            collectionView .reloadData()
        }
        
        return cell
    }
    
    func waterfallLayout(_ layout: HYWaterfallLayout, atItemIndex: Int) -> CGFloat {
        return CGFloat(arc4random_uniform(100) + 100)
    }
}
