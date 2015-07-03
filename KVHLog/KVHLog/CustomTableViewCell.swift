//
//  CustomTableViewCell.swift
//  KVHLog
//
//  Created by baljinnyam on 2015/06/14.
//  Copyright (c) 2015年 baljinnyam. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 50
            super.frame = frame
        }
    }
}
