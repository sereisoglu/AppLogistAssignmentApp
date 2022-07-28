//
//  GroceryCell.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

final class GroceryCell: UICollectionViewCell {
    
    private let imageView = DownloadableImageView(cornerRadius: 6, borderWidth: 1)
    private let label = Label(type: .body1, weight: .semibold, color: .accentPrimary)
    private let subLabel = Label(type: .body2, weight: .semibold, color: .tintPrimary)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(
            imageView,
            stack(
                label,
                subLabel
            ),
            spacing: 4
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.cancelImageDownload()
    }
    
    func set(grocery: GroceryModel) {
        imageView.set(imageUrl: grocery.imageUrl)
        label.set(text: grocery.formattedPrice)
        subLabel.set(text: grocery.name ?? "No name")
    }
    
    static func getSize(width: CGFloat) -> CGSize {
        let aspectRatio: CGFloat = 5 / 6
        
        let labelHeight = FontType.body1.value.lineHeight
        let subLabelHeight = FontType.body2.value.lineHeight
        
        return .init(
            width: width,
            height: (width * aspectRatio) + 4 + labelHeight + subLabelHeight
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
