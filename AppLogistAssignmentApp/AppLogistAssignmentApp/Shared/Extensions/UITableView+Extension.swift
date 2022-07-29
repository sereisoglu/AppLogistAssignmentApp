//
//  UITableView+Extension.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

extension UITableView {
    func registerHeader(_ cellClass: AnyClass) {
        let reuseIdentifier = String(describing: cellClass)
        
        register(cellClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableHeader<T: UITableViewHeaderFooterView>() -> T {
        let reuseIdentifier = String(describing: T.self)
        
        return dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as! T
    }
}

extension UITableView {
    func registerCell(_ cellClass: AnyClass) {
        let reuseIdentifier = String(describing: cellClass)
        
        register(cellClass, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: T.self)
        
        return dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}

extension UITableView {
    func registerFooter(_ cellClass: AnyClass) {
        let reuseIdentifier = String(describing: cellClass)
        
        register(cellClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableFooter<T: UITableViewHeaderFooterView>() -> T {
        let reuseIdentifier = String(describing: T.self)
        
        return dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) as! T
    }
}

