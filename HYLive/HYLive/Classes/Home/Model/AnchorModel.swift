//
//  AnchorModel.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/8/1.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class AnchorModel: BaseModel {

    var roomid: Int = 0 // 房间号
    var live: Int = 0   // 是否在直播
    var push: Int = 0   // 直播显示方式
    var focus: Int = 0  // 关注数量
    var name: String = ""   // 名称
    var pic51: String = ""  // 图片链接
    var pic74: String = ""  // 图片链接
    var isEventIndex: Bool = false // 是否使用大图
}
