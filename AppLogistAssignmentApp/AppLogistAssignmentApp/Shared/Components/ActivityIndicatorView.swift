//
//  ActivityIndicatorView.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import LBTATools

enum ActivityIndicatorViewSize {
    case pt18
    case pt20
    case pt22
    case pt24
    case pt30
    
    var value: CGSize {
        switch self{
        case .pt18:
            return .equalEdge(18)
        case .pt20:
            return .equalEdge(20)
        case .pt22:
            return .equalEdge(22)
        case .pt24:
            return .equalEdge(24)
        case .pt30:
            return .equalEdge(30)
        }
    }
}

final class ActivityIndicatorView: UIView {
    
    var animating: Bool = false {
        didSet {
            isHidden = !animating
            
            if animating {
                activityIndicatorView.startAnimating()
            } else {
                activityIndicatorView.stopAnimating()
            }
        }
    }
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    init(
        size: ActivityIndicatorViewSize,
        tintColor: Color?
    ) {
        super.init(frame: .zero)
        
        isHidden = true
        
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.isUserInteractionEnabled = false
        
        let aspectRatio = size.value.width / ActivityIndicatorViewSize.pt20.value.width
        activityIndicatorView.transform = CGAffineTransform(scaleX: aspectRatio, y: aspectRatio)
        
        withSize(size.value)
        
        activityIndicatorView.addCenterInSuperview(superview: self)
        
        if let tintColor = tintColor {
            set(tintColor: tintColor)
        }
    }
    
    func set(tintColor: Color) {
        activityIndicatorView.color = tintColor.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
