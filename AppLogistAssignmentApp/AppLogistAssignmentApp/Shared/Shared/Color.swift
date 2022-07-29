//
//  Color.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

enum Color: String {
    case accentPrimary = "accent/primary"
    
    case tintPrimary = "tint/primary"
    case tintSecondary  = "tint/secondary"
    case tintTertiary = "tint/tertiary"
    case tintWhite = "tint/white"
    case tintRed = "tint/red"
    case tintBlue = "tint/blue"
    
    case fillPrimary = "fill/primary"
    
    case backgroundDefault = "background/default"
    
    case clear
    
    var value: UIColor {
        switch self {
        case .clear:
            return UIColor.clear
        default:
            return UIColor(named: "\(rawValue)") ?? UIColor.clear
        }
    }
}
