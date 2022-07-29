//
//  MyCartCell.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import LBTATools

final class MyCartCell: UITableViewCell {
    
    private let downloadableImageView = DownloadableImageView(cornerRadius: 6, borderWidth: 1)
    private let label = Label(type: .body1, weight: .semibold, color: .tintPrimary)
    private let subLabel = Label(type: .body2, weight: .medium, color: .accentPrimary)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let imageAspectRatio: CGFloat = 5 / 6
        let imageWidth: CGFloat = 80
        let imageHeight = imageWidth * imageAspectRatio
        
        hstack(
            downloadableImageView.withSize(.init(width: imageWidth, height: imageHeight)),
            stack(
                label,
                subLabel
            ),
            spacing: 10, alignment: .center
        ).withMargins(.linearSides(v: 10, h: 15))
        
        separatorInset = .init(
            top: 0,
            left: 15 + imageWidth + 10,
            bottom: 0,
            right: 0
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadableImageView.cancelImageDownload()
    }
    
    func set(grocery: GroceryUIModel) {
        downloadableImageView.set(imageUrl: grocery.imageUrl)
        label.set(text: grocery.name)
        subLabel.set(text: grocery.priceText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
