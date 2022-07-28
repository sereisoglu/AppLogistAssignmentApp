//
//  Endpoint+Parameters.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation
import Alamofire

extension Endpoint {
    
    var parameters: Parameters? {
        switch self {
        case .list:
            return nil
        case .checkout(let products):
            return [
                "products": products
            ]
        }
    }
}
