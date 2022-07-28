//
//  IconImageView.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

final class IconImageView: UIImageView {
    
    init(
        size: IconSize,
        icon: Icon?,
        tintColor: Color?
    ) {
        super.init(frame: .zero)
        
        withSize(size.value)
        
        if let icon = icon {
            set(icon: icon)
        }
        
        if let tintColor = tintColor {
            set(color: tintColor)
        }
    }
    
    func set(icon: Icon) {
        image = icon.value
    }
    
    func set(color: Color) {
        tintColor = color.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
