//
//  StepperView.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import LBTATools

protocol StepperViewDelegate: AnyObject {
    
    func handleMinusButton(index: Int)
    func handlePlusButton(index: Int)
}

final class StepperView: UIView {
    
    weak var delegate: StepperViewDelegate?
    
    private lazy var minusButton = UIButton(
        image: Icon.minus.value,
        tintColor: Color.tintPrimary.value,
        target: self,
        action: #selector(handleMinusButton)
    )
    
    private let label = Label(
        type: .body3,
        weight: .medium,
        color: .tintPrimary,
        alignment: .center
    )
    
    private lazy var plusButton = UIButton(
        image: Icon.plus.value,
        tintColor: Color.tintPrimary.value,
        target: self,
        action: #selector(handlePlusButton)
    )
    
    init(haveShadow: Bool = false) {
        super.init(frame: .zero)
        
        backgroundColor = Color.backgroundDefault.value
        
        layer.cornerRadius = 4
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        
        hstack(
            minusButton.withSize(.equalEdge(20)),
            label.withWidth(25),
            plusButton.withSize(.equalEdge(20))
        ).withMargins(.allSides(2))
        
        minusButton.isHidden = true
        label.isHidden = true
        
        if haveShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.4
            layer.shadowOffset = .zero
            layer.shadowRadius = 10
    //        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    func set(value: Int) {
        label.set(text: "\(value)")
        
        minusButton.isHidden = value == 0
        label.isHidden = value == 0
    }
    
    func set(index: Int) {
        tag = index
    }
    
    @objc
    private func handleMinusButton() {
        delegate?.handleMinusButton(index: tag)
    }
    
    @objc
    private func handlePlusButton() {
        delegate?.handlePlusButton(index: tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
