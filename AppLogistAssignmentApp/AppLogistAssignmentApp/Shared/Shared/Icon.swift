//
//  Icon.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

enum Icon: String {
    case cart = "cart"
    case minus = "minus"
    case plus = "plus"
    
    var value: UIImage {
        return UIImage(named: "\(rawValue)") ?? UIImage()
    }
}
