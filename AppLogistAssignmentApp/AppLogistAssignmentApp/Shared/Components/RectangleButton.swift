//
//  RectangleButton.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import LBTATools

final class RectangleButton: UIButton {
    
    private let label = Label(type: .body1, weight: .bold, color: .tintWhite, alignment: .center)
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 1,
                options: .curveEaseOut,
                animations: { [weak self] in
                    guard let self = self else {
                        return
                    }
                    
                    self.transform = self.isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
                }
            )
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Color.accentPrimary.value
        
        layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        clipsToBounds = true
        
        label.addCenterInSuperview(superview: self)
        
        label.isUserInteractionEnabled = false
    }
    
    func set(text: String) {
        label.set(text: text)
    }
    
    func set(isEnabled: Bool) {
        self.isEnabled = isEnabled
        
        backgroundColor = isEnabled ? Color.accentPrimary.value : Color.tintSecondary.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
