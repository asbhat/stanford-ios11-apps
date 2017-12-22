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

    func emphasize() {
        let startingBackground = self.backgroundColor
        UIView.animate(
            withDuration: 1.0,
            delay: 0,
            options: UIViewAnimationOptions.allowUserInteraction,
            animations: { self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1) },
            completion: { _ in self.deemphasize(backTo: startingBackground) }
        )
        layoutSubviews()
    }

    private func deemphasize(backTo color: UIColor?) {
        let backgroundColor = color ?? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        UIView.animate(
            withDuration: 1.0,
            delay: 0,
            options: UIViewAnimationOptions.allowUserInteraction,
            animations: { self.backgroundColor = backgroundColor },
            completion: nil
        )
        layoutSubviews()
    }

}
