//
//  PaddingLabel.swift
//  DakeAndDevileCorps
//
//  Created by 최동권 on 2022/07/31.
//

import UIKit 

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets()
    
    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }
}
