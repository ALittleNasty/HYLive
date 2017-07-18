//
//  NetworkTools.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/7/18.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    
    class func requestData(_ type: MethodType, URLString: String, parameters : [String: Any]? = nil, finishedCallback: @escaping (_ result: Any) -> ()) {
        
        // 获取请求类型
        let method = (type == .get) ? HTTPMethod.get : HTTPMethod.post
        
        // 发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil).validate(contentType: ["text/plain"]).responseJSON { (response) in
            
            // 获取结果
            guard let result = response.result.value else {
                print(response.error!)
                return
            }
            
            // 回调结果
            finishedCallback(result)
        }
    }
}
