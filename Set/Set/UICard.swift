//
//  UICard.swift
//  Set
//
//  Created by Aditya Bhat on 12/8/17.
//  Copyright © 2017 Aditya Bhat. All rights reserved.
//

import UIKit

@IBDesignable
class UICard: UIButton {

    // not resizing properly with multiline text, so need to resize based on titleLabel
    override var intrinsicContentSize: CGSize {
        return titleLabel?.intrinsicContentSize ?? CGSize.zero
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.preferredMaxLayoutWidth = titleLabel!.frame.size.width
        layer.cornerRadius = 8
    }

}
