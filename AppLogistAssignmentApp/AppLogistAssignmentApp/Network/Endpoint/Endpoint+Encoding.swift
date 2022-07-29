//
//  Endpoint+Encoding.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation
import Alamofire

extension Endpoint {
    
    var encoding: ParameterEncoding {
        switch self {
        case .list:
            return URLEncoding.default
        case .checkout:
            return JSONEncoding.default
        }
    }
}
