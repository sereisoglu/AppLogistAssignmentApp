//
//  Endpoint.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation
import Alamofire

enum Endpoint {
    
    case list
    case checkout(products: [ProductModel])
}
