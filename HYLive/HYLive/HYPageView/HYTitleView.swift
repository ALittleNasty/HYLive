//
//  HYTitleView.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/6/27.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

/*
 : class 表示: 只有类才可以遵守这个协议(结构体和枚举类型的均不可以)
 */
protocol HYTitleViewDelegate: class {
    
    func titleView(_ titleView: HYTitleView, targetIndex: Int)
}

class HYTitleView: UIView {

    // MARK: - 属性
    weak var delegate: HYTitleViewDelegate?
    fileprivate var titles: [String]
    fileprivate var style: HYPageStyle
    
    // 选中label的索引, 默认为第一个: 0
    fileprivate var selectedIndex: Int = 0
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    fileprivate lazy var normalRGB: (CGFloat, CGFloat, CGFloat) = self.style.titleNormalColor.getRGBValue()
    fileprivate lazy var selectRGB: (CGFloat, CGFloat, CGFloat) = self.style.titleSelectedColor.getRGBValue()
    fileprivate lazy var deltaRGB: (CGFloat, CGFloat, CGFloat) = {
        
        let deltaR = self.selectRGB.0 - self.normalRGB.0
        let deltaG = self.selectRGB.1 - self.normalRGB.1
        let deltaB = self.selectRGB.2 - self.normalRGB.2
        return (deltaR, deltaG, deltaB)
    }()
    
    fileprivate lazy var scrollView: UIScrollView = {
    
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        // 点击状态栏不允许scrollView回到顶部
        scrollView.scrollsToTop = false
        return scrollView
    }()
    
    fileprivate lazy var bottomLine: UIView = {
        
        let line = UIView()
        line.backgroundColor = self.style.bottomLineColor
        return line
    }()
    
    // MARK: - 构造函数
    init(frame: CGRect, titles: [String], style: HYPageStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - 设置UI界面
extension HYTitleView {

    fileprivate func setupUI() {
        // 1. 添加scrollView
        addSubview(scrollView)
        
        // 2. 添加标题
        setTitleLabels()
        
        // 3. 初始化底部的滚动条
        if style.isShowBottomLine == true {
            setBottomLine()
        }
    }
    
    private func setBottomLine() {
    
        scrollView.addSubview(bottomLine)
        bottomLine.frame = titleLabels.first!.frame
        bottomLine.frame.origin.y = style.titleHeight - style.bottomLineHeight
        bottomLine.frame.size.height = style.bottomLineHeight
    }
    
    private func setTitleLabels() {
        
        // 1.创建label
        for (i, title) in titles.enumerated() {
            
            // 1. 创建label
            let titleLabel = UILabel()
            
            // 2. 设置label的属性
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.tag = i
            titleLabel.textColor = (i == 0) ? style.titleSelectedColor : style.titleNormalColor
            titleLabel.font = style.titleFont
            titleLabel.isUserInteractionEnabled = true
            
            // 3. 添加label到scrollView上面
            scrollView.addSubview(titleLabel)
            
            // 4. 监听label点击
            // swift中selector写法:  #selector(方法名称)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickLabelWith(tapGesture:)))
            titleLabel.addGestureRecognizer(tapGesture)
         
            // 5. 添加label到数组中
            titleLabels.append(titleLabel)
        }
        
        // 2. 设置label.frame
        let lableH: CGFloat = style.titleHeight
        let lableY: CGFloat = 0.0
        var labelX: CGFloat = 0.0
        var labelW: CGFloat = bounds.width / CGFloat(titleLabels.count)
        
        for (i, label) in titleLabels.enumerated() {
            
            if style.isTitleViewScrollEnable { // 可以滚动
                
                // 计算文本宽度
                labelW = (label.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0.0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: style.titleFont], context: nil).width
                labelX = (i == 0) ? style.titleMargin * 0.5 : (titleLabels[i-1].frame.maxX + style.titleMargin)
                
            } else {    // 不可以滚动
                labelX = labelW * CGFloat(i)
            }
            
            label.frame = CGRect(x: labelX, y: lableY, width: labelW, height: lableH)
        }
        
        // 3. 可以滚动的时候要设置scrollView的contentSize
        if style.isTitleViewScrollEnable {
            let width = titleLabels.last!.frame.maxX + style.titleMargin * 0.5
            scrollView.contentSize = CGSize(width: width, height: bounds.height)
        }
        
        // 4. 设置缩放
        if style.isNeedTitleScale {
            titleLabels.first?.transform = CGAffineTransform(scaleX: style.maxScale, y: style.maxScale)
        }
    }
}

// MARK: - 点击事件处理
extension HYTitleView {
    
    @objc fileprivate func clickLabelWith(tapGesture: UITapGestureRecognizer) {
        
        guard let targetLabel = tapGesture.view as? UILabel else {
            return
        }
        
        // 如果点击的label和选中的label相同, 那么直接返回
        guard targetLabel.tag != selectedIndex else {
            return
        }
        
        let sourceLabel = titleLabels[selectedIndex];
        // 1.将原来的label字体改为normalColor, 选中的label字体颜色换为selectedColor
        adjustTitleLabelPosition(targetIndex: targetLabel.tag)
        // 2.改变选中label的索引
        selectedIndex = targetLabel.tag
        
        // 3. 设置缩放
        if style.isNeedTitleScale {
            
            UIView.animate(withDuration: 0.25, animations: {
                targetLabel.transform = CGAffineTransform(scaleX: self.style.maxScale, y: self.style.maxScale)
                sourceLabel.transform = CGAffineTransform.identity
            })
        }
        
        // 4.改变滚动条的位置
        // 因为滚动条的变化依赖于titleLabel的frame, 但是transform会改变frame, 所以先进行缩放变换, 再改变bottomLine的位置
        if style.isShowBottomLine {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.bottomLine.frame.origin.x = targetLabel.frame.origin.x
                self.bottomLine.frame.size.width = targetLabel.frame.width
            })
        }
        
        // 5.通知代理, 与contentView进行联动
        // ?. 可选链:  若可选类型有值将会执行代码, 否则什么也不干
        delegate?.titleView(self, targetIndex: selectedIndex)
    }
    
    fileprivate func adjustTitleLabelPosition(targetIndex: Int) {
        
        guard selectedIndex != targetIndex else {
            return
        }
        
        let sourceLabel = titleLabels[selectedIndex]
        let targetLabel = titleLabels[targetIndex]
        
        sourceLabel.textColor = style.titleNormalColor
        targetLabel.textColor = style.titleSelectedColor
        
        selectedIndex = targetIndex
        
        var offsetX = targetLabel.center.x - bounds.width * 0.5
        if offsetX < 0.0 {
            offsetX = 0.0
        } else if offsetX > scrollView.contentSize.width - scrollView.bounds.width {
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: true);
    }
}

// MARK: - HYContentViewDelegate
extension HYTitleView: HYContentViewDelegate {

    func contentView(_ contentView: HYContentView, didEndScroll inIndex: Int) {
        
        adjustTitleLabelPosition(targetIndex: inIndex)
    }
    
    func contentView(_ contentView: HYContentView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        
        // 1. 根据index获取对应的label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2. 颜色渐变
        sourceLabel.textColor = UIColor(r: selectRGB.0 - deltaRGB.0 * progress, g: selectRGB.1 - deltaRGB.1 * progress, b: selectRGB.2 - deltaRGB.2 * progress)
        targetLabel.textColor = UIColor(r: normalRGB.0 + deltaRGB.0 * progress, g: normalRGB.1 + deltaRGB.1 * progress, b: normalRGB.2 + deltaRGB.2 * progress)
        
        // 3. 设置缩放
        if style.isNeedTitleScale {
            
            let deltaScale = (style.maxScale - 1.0)
            
            targetLabel.transform = CGAffineTransform(scaleX: (1.0 + deltaScale * progress), y: (1.0 + deltaScale * progress))
            sourceLabel.transform = CGAffineTransform(scaleX: (style.maxScale - deltaScale * progress), y: (style.maxScale - deltaScale * progress))
        }
        
        // 4. 计算底部滚动条的width和x的变化
        // 因为滚动条的变化依赖于titleLabel的frame, 但是transform会改变frame, 所以先进行缩放变换, 再改变bottomLine的位置
        if style.isShowBottomLine {
            
            let deltaWidth = targetLabel.frame.width - sourceLabel.frame.width
            let deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
            bottomLine.frame.origin.x = sourceLabel.frame.origin.x + progress * deltaX
            bottomLine.frame.size.width = sourceLabel.frame.width + progress * deltaWidth
        }
    }
}















