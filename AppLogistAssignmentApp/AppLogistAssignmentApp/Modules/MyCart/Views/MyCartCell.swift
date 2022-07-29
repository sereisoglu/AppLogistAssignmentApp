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
    private let label = Label(type: .body1, weight: .semibold, color: .accentPrimary)
    private let subLabel = Label(type: .body2, weight: .semibold, color: .tintPrimary)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let imageAspectRatio: CGFloat = 5 / 6
        let imageWidth: CGFloat = 100
        let imageHeight = imageWidth * imageAspectRatio
        
        hstack(
            downloadableImageView.withSize(.init(width: imageWidth, height: imageHeight)),
            stack(
                label,
                subLabel
            ),
            spacing: 10
        ).withMargins(.init(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        downloadableImageView.cancelImageDownload()
    }
    
    func set(grocery: GroceryUIModel) {
        downloadableImageView.set(imageUrl: grocery.imageUrl)
        label.set(text: grocery.price)
        subLabel.set(text: grocery.name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
