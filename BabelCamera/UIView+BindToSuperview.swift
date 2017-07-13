//
//  UIView+BindToSuperview.swift
//  BabelCamera
//
//  Created by Andy Cho on 2017-07-13.
//  Copyright © 2017 AcroMace. All rights reserved.
//

import UIKit

extension UIView {

    func fillSuperview() {
        guard let superview = self.superview else {
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[subview]-0-|",
            options: .directionLeadingToTrailing,
            metrics: nil,
            views: ["subview": self]))
        superview.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[subview]-0-|",
            options: .directionLeadingToTrailing,
            metrics: nil,
            views: ["subview": self]))
    }
}
