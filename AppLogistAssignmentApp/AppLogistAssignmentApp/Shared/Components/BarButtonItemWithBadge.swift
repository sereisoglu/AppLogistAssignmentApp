//
//  BarButtonItemWithBadge.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//


import UIKit
import LBTATools

final class BarButtonItemWithBadge: UIButton {
    
    private let iconImageView = UIImageView()
    
    private let badgeView = UIView(backgroundColor: Color.tintRed.value)
    private let badgeLabel = Label(type: .body3, weight: .semibold, color: .tintWhite, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        iconImageView.addFillSuperview(superview: self)
        
        badgeView.layer.cornerRadius = 18 / 2
        badgeView.clipsToBounds = true
        
        addSubview(badgeView)
        badgeView.anchor(
            .trailing(trailingAnchor, constant: -6),
            .top(topAnchor, constant: -4),
            .width(22),
            .height(18)
        )
        
        badgeLabel.addFillSuperview(superview: badgeView)
        
        badgeView.isHidden = true
        
        iconImageView.isUserInteractionEnabled = false
        badgeView.isUserInteractionEnabled = false
    }
    
    func set(icon: Icon) {
        iconImageView.image = icon.value
    }
    
    func set(badgeValue: Int) {
        badgeLabel.set(text: "\(badgeValue)")
        badgeView.isHidden = badgeValue == 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
