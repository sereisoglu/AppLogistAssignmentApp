//
//  UIEdgeInsets+Extension.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

extension UIEdgeInsets {
    static func linearSides(v vertical: CGFloat, h horizontal: CGFloat) -> UIEdgeInsets {
        return .init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
