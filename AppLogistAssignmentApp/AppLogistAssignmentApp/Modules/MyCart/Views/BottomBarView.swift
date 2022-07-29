//
//  BottomBarView.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import LBTATools

protocol BottomBarViewDelegate: AnyObject {
    
    func handleButton()
}

final class BottomBarView: UIView {
    
    weak var delegate: BottomBarViewDelegate?
    
    private let seperatorView = UIView(backgroundColor: Color.tintSecondary.value)
    
    private let leftLabel = Label(type: .title3, weight: .medium, color: .tintSecondary)
    private let rightLabel = Label(type: .title3, weight: .bold, color: .tintPrimary)
    
    private let button = RectangleButton()
    
    private let visualEffectView = UIVisualEffectView()
    
    init() {
        super.init(frame: .zero)
        
        if #available(iOS 13.0, *) {
            visualEffectView.effect = UIBlurEffect(style: .systemChromeMaterial)
        } else {
            visualEffectView.effect = UIBlurEffect(style: .extraLight)
        }
        visualEffectView.frame = bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(visualEffectView)
        
        addSubview(seperatorView)
        seperatorView.anchor(
            .leading(leadingAnchor),
            .trailing(trailingAnchor),
            .top(topAnchor),
            .height(1)
        )
        
        let isSmall = UIScreen.main.bounds.width <= 350
        
        if isSmall {
            hstack(
                stack(
                    leftLabel,
                    rightLabel
                ),
                UIView(),
                button.withSize(.init(width: 120, height: 50)),
                spacing: 5,
                alignment: .center
            ).padLeft(20).padRight(20)
        } else {
            hstack(
                hstack(
                    leftLabel,
                    rightLabel,
                    spacing: 10,
                    alignment: .center
                ),
                UIView(),
                button.withSize(.init(width: 150, height: 50)),
                spacing: 5,
                alignment: .center
            ).padLeft(20).padRight(20)
        }
        
        button.addTarget(self, action: #selector(handleButton), for: .primaryActionTriggered)
        
        leftLabel.adjustsFontSizeToFitWidth = true
        leftLabel.minimumScaleFactor = 0.6
        leftLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        rightLabel.adjustsFontSizeToFitWidth = true
        rightLabel.minimumScaleFactor = 0.6
        rightLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    func set(leftLabelText: String) {
        leftLabel.set(text: leftLabelText)
    }
    
    func set(rightLabelText: String) {
        rightLabel.set(text: rightLabelText)
    }
    
    func set(buttonText: String) {
        button.set(text: buttonText)
    }
    
    func set(buttonIsEnabled: Bool) {
        button.set(isEnabled: buttonIsEnabled)
    }
    
    @objc
    private func handleButton() {
        delegate?.handleButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
