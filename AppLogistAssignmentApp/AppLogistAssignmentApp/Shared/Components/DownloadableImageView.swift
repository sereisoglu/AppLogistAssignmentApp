//
//  DownloadableImageView.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import Nuke

final class DownloadableImageView: UIImageView {
    
    init(
        cornerRadius: CGFloat,
        borderWidth: CGFloat,
        contentMode: UIView.ContentMode = .scaleAspectFill
    ) {
        super.init(frame: .zero)
        
        backgroundColor = Color.fillPrimary.value
        
        layer.cornerRadius = cornerRadius
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
        clipsToBounds = true
        
        layer.borderWidth = borderWidth
        layer.borderColor = Color.tintPrimary.value.withAlphaComponent(0.25).cgColor
        frame = frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        
        self.contentMode = contentMode
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *),
           traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            layer.borderColor = Color.tintPrimary.value.withAlphaComponent(0.25).cgColor
        }
    }
    
    func set(imageUrl: String?) {
        guard let imageUrl = imageUrl,
              let url = URL(string: imageUrl) else {
            isHidden = true
            
            return
        }
        
        Nuke.loadImage(
            with: url,
            options: .init(
                transition: .fadeIn(duration: 0.33)
            ),
            into: self
        )
    }
    
    func cancelImageDownload() {
        Nuke.cancelRequest(for: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
