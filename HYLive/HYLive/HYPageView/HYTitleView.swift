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
    fileprivate lazy var scrollView: UIScrollView = {
    
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        // 点击状态栏不允许scrollView回到顶部
        scrollView.scrollsToTop = false
        return scrollView
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
    }
}

// MARK: - 点击事件处理
extension HYTitleView {
    
    @objc fileprivate func clickLabelWith(tapGesture: UITapGestureRecognizer) {
//        let tapLabel = tapGesture.view as? UILabel
//        // ?. 可选链
//        print(tapLabel?.tag ?? 10000)
        
        guard let targetLabel = tapGesture.view as? UILabel else {
            return
        }
        
        // 如果点击的label和选中的label相同, 那么直接返回
        guard targetLabel.tag != selectedIndex else {
            return
        }
        
        print(#function + "  \(targetLabel.tag)")
        
        // 1.将原来的label字体改为normalColor, 选中的label字体颜色换为selectedColor
        let sourceLabel = titleLabels[selectedIndex]
        sourceLabel.textColor = style.titleNormalColor
        targetLabel.textColor = style.titleSelectedColor
        // 2.改变选中label的索引
        selectedIndex = targetLabel.tag
        
        // 3.改变选中label的位置, 使其居中
        var offsetX = targetLabel.center.x - bounds.width * 0.5
        if offsetX < 0.0 {
            offsetX = 0.0
        } else if offsetX > scrollView.contentSize.width - scrollView.bounds.width {
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: true);
        
        // 4.通知代理, 与contentView进行联动
        // ?. 可选链:  若可选类型有值将会执行代码, 否则什么也不干
        delegate?.titleView(self, targetIndex: selectedIndex)
    }
}

















