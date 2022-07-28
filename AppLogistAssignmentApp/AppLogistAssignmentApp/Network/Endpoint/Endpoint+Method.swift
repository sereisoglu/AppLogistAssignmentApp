//
//  Endpoint+Method.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation
import Alamofire

extension Endpoint {
    
    var method: HTTPMethod {
        switch self {
        case .list:
            return .get
        case .checkout:
            return .post
        }
    }
}
