//
//  UICollectionView+Extension.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

extension UICollectionView {
    func registerHeader(_ viewClass: AnyClass) {
        let reuseIdentifier = String(describing: viewClass)
        
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    func registerCell(_ cellClass: AnyClass) {
        let reuseIdentifier = String(describing: cellClass)
        
        register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}

extension UICollectionView {
    func registerFooter(_ viewClass: AnyClass) {
        let reuseIdentifier = String(describing: viewClass)
        
        register(viewClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableFooter<T: UICollectionReusableView>(for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}
