//
//  CheckBoxButton.swift
//  KVHLog
//
//  Created by baljinnyam on 2015/06/22.
//  Copyright (c) 2015年 baljinnyam. All rights reserved.
//

import UIKit
protocol CheckboxDelegate {
    // #1
    func didSelectCheckbox(state: Bool, identifier: Int, title: String);
}
class CheckBoxButton : UIButton {
    var mDelegate: CheckboxDelegate?;
    // #1
    required init(coder: NSCoder) {
        super.init(coder:coder);
    }
    
    // #2
    init(frame: CGRect, title: String, selected: Bool) {
        super.init(frame: frame);
        self.adjustEdgeInsets();
        self.applyStyle();
        self.setTitle(title, forState: UIControlState.Normal);
        self.addTarget(self, action: "onTouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside);
    }
    
    func adjustEdgeInsets() {
        let lLeftInset: CGFloat = 8.0;
        // #3
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left;
        // #4
        self.imageEdgeInsets = UIEdgeInsetsMake(0.0 as CGFloat, lLeftInset, 0.0 as CGFloat, 0.0 as CGFloat);
        // #5
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0 as CGFloat, (lLeftInset * 2), 0.0 as CGFloat, 0.0 as CGFloat);
    }
    
    // #6
    func applyStyle() {
        self.setImage(UIImage(named: "checked_checkbox"), forState: UIControlState.Selected);
        self.setImage(UIImage(named: "unchecked_checkbox"), forState: UIControlState.Normal);
        self.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal);
    }
    
    func onTouchUpInside(sender: UIButton) {
        // #7
        self.selected = !self.selected;
        // #8
        mDelegate?.didSelectCheckbox(self.selected, identifier: self.tag, title: self.titleLabel!.text!);
    }
}
