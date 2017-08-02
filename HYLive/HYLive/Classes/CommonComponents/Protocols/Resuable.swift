//
//  TableViewResuable.swift
//  ProtocolUsageDemo
//
//  Created by ALittleNasty on 2017/7/26.
//  Copyright © 2017年 ALittleNasty. All rights reserved.

/**
 *  tableView, collectionView的注册cell的协议
 */

import UIKit

protocol Resuable {

    static var reuseID : String { get }
    
    static var nib: UINib? { get }
}

extension Resuable {

    static var reuseID : String {
        return "\(self)"
    }
    
    static var nib: UINib? {
        return nil
    }
}


extension UITableView {

    func registerCell<T: UITableViewCell>(_ cell: T.Type) where T: Resuable {
        
        if let nib = T.nib {
            register(nib, forCellReuseIdentifier: cell.reuseID)
        }else {
            register(cell, forCellReuseIdentifier: cell.reuseID)
        } 
    }
    
    func dequeueReusableCell<T: Resuable>(at indexPath: IndexPath) -> T {
        
        return dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as! T
    }
}

extension UICollectionView {

    func registerCell<T: UICollectionViewCell>(_ cell: T.Type) where T: Resuable {
    
        if let nib = T.nib {
            register(nib, forCellWithReuseIdentifier: T.reuseID)
        } else {
            register(cell, forCellWithReuseIdentifier: T.reuseID)
        }
    }
    
    func dequeueReusableCell<T: Resuable>(at indexPath: IndexPath) -> T {
    
        return dequeueReusableCell(withReuseIdentifier: T.reuseID, for: indexPath) as! T
    }
}
