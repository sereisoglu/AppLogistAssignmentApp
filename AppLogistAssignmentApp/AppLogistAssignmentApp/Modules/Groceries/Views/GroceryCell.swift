//
//  GroceryCell.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import LBTATools

final class GroceryCell: UICollectionViewCell {
    
    private let downloadableImageView = DownloadableImageView(cornerRadius: 6, borderWidth: 1)
    private let label = Label(type: .body1, weight: .semibold, color: .accentPrimary)
    private let subLabel = Label(type: .body2, weight: .medium, color: .tintPrimary)
    private let stepperView = StepperView(haveShadow: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        
        stack(
            downloadableImageView,
            stack(
                label,
                subLabel
            ),
            spacing: 4
        )
        
        addSubview(stepperView)
        stepperView.anchor(
            .trailing(trailingAnchor, constant: 5),
            .top(topAnchor, constant: 5)
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadableImageView.cancelImageDownload()
    }
    
    func set(grocery: GroceryUIModel, index: Int, delegate: StepperViewDelegate?) {
        downloadableImageView.set(imageUrl: grocery.imageUrl)
        label.set(text: grocery.priceText)
        subLabel.set(text: grocery.name)
        
        stepperView.set(value: grocery.amount)
        stepperView.set(index: index)
        stepperView.delegate = delegate
    }
    
    static func getSize(width: CGFloat) -> CGSize {
        let imageAspectRatio: CGFloat = 5 / 6
        
        let labelHeight = FontType.body1.value.lineHeight
        let subLabelHeight = FontType.body2.value.lineHeight
        
        return .init(
            width: width,
            height: (width * imageAspectRatio) + 4 + labelHeight + subLabelHeight
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
