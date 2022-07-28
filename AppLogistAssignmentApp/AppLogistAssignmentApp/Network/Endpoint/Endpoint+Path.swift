//
//  Endpoint+Path.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation

extension Endpoint {
    
    var path: String {
        switch self {
        case .list:
            return "list"
        case .checkout:
            return "checkout"
        }
    }
}
