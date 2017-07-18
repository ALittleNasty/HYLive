//
//  KingfisherExtension.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/18.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImage(_ URLString: String?, _ placeholderImageName: String?) {
    
        guard let URLString = URLString else {
            return
        }
        
        guard let placeholderName = placeholderImageName else {
            return
        }
        
        guard let url = URL(string: URLString) else {
            return
        }
        
        kf.setImage(with: url, placeholder: UIImage(named: placeholderName), options: nil, progressBlock: nil, completionHandler: nil)
    }
}
