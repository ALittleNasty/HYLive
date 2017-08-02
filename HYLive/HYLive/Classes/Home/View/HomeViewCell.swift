//
//  HomeViewCell.swift
//  HYLive
//
//  Created by ALittleNasty on 2017/8/2.
//  Copyright © 2017年 ALittleNasty. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell, Resuable {

    static var nib: UINib? {
        return UINib(nibName: "HomeViewCell", bundle: nil)
    }
    
    // MARK: - 控件
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleBtn: UIButton!
    
    // MARK: - 绑定的数据模型
    public var anchorModel: AnchorModel? {
    
        didSet {
        
            albumImageView.setImage(anchorModel!.isEventIndex ? anchorModel!.pic74 : anchorModel!.pic51, "")
            liveImageView.isHidden = (anchorModel?.live == 0)
            nickNameLabel.text = anchorModel?.name
            onlinePeopleBtn.setTitle(" \(anchorModel?.focus ?? 0)", for: .normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        albumImageView.layer.cornerRadius = 5.0
        albumImageView.layer.masksToBounds = true
    }

}
