//
//  HYPageStyle.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/27.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HYPageStyle {

    var titleHeight: CGFloat = 44.0 // 标题View的高度
    var titleNormalColor: UIColor = UIColor(r: 0, g: 0, b: 0) // 标题的正常状态颜色
    var titleSelectedColor: UIColor = UIColor(r: 255, g: 127, b: 0) // 标题文本的选种颜色
    var titleFont: UIFont = UIFont.systemFont(ofSize: 14) // 标题文本的字体大小
    var isTitleViewScrollEnable: Bool = false   // 标题是否可以滚动(默认不可以)
    var titleMargin: CGFloat = 20 // 标题可以滚动情况下的文字间距
    var isShowBottomLine: Bool = true // 默认显示标题下方的滚动条
    var bottomLineColor: UIColor = UIColor(r: 255, g: 127, b: 0) // 滚动条颜色
    var bottomLineHeight: CGFloat = 2 // 滚动条高度
    var isNeedTitleScale: Bool = false // 标题是否需要缩放(默认无缩放效果)
    var maxScale: CGFloat = 1.2 // 最大缩放的倍数
}
