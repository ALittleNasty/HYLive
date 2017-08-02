//
//  HomeViewModel.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/8/2.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HomeViewModel {
    
    // MARK: - 对外公开的原创作者的数据模型数组
    public lazy var anchorModels = [AnchorModel]()
}

// MARK: - 请求数据
extension HomeViewModel {

    func loadHomeData(type: HomeType, index: Int, finishedCallback: @escaping () -> ()) {
    
        let url = "http://qf.56.com/home/v4/moreAnchor.ios"
        let params = ["type" : type.type, "index" : index, "size" : 48]
        NetworkTools.requestData(.get, URLString: url, parameters: params) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let messageDict = resultDict["message"] as? [String : Any] else { return }
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else { return }
            
            for (index, dict) in dataArray.enumerated() {
                
                let anchor = AnchorModel(dict: dict)
                anchor.isEventIndex = index % 2 == 0
                self.anchorModels.append(anchor)
            }
            
            finishedCallback()
        }
    }
}
