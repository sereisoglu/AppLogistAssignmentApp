//
//  ErrorModel.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation

struct ErrorModel: Decodable, Error {
    var error: String?
}

// {
//     "error": "Satın alınmak istenen () ürün bulunamadı"
// }
