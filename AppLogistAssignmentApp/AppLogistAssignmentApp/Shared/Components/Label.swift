//
//  Label.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

final class Label: UILabel {
    
    private var attributes: [NSAttributedString.Key : Any]
    
    init(
        text: String? = nil,
        type: FontType,
        weight: FontWeight,
        color: Color?,
        alignment: NSTextAlignment = .left,
        numberOfLines: Int = 1,
        lineBreakMode: NSLineBreakMode = .byTruncatingTail
    ) {
        attributes = AttributedStringUtility.generate(type: type, weight: weight, color: nil, alignment: alignment, lineBreakMode: lineBreakMode)
        
        super.init(frame: .zero)
        
        set(text: text)
        set(color: color)
        
        self.numberOfLines = numberOfLines
        
        sizeToFit()
    }
    
    func set(text: String?) {
        guard let text = text else {
            return
        }
        
        attributedText = .init(string: text, attributes: attributes)
    }
    
    func set(color: Color?) {
        guard let color = color else {
            return
        }
        
        textColor = color.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
