//
//  Icon.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import LBTATools

enum Icon: String {
    case cart = "cart"
    case minus = "minus"
    case plus = "plus"
    
    var value: UIImage {
        return UIImage(named: "\(rawValue)") ?? UIImage()
    }
}

enum IconSize {
    case pt22
    
    var value: CGSize {
        switch self {
        case .pt22:
            return .equalEdge(22)
        }
    }
}
