//
//  CheckoutResponseModel.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation

struct CheckoutResponseModel: Decodable {
    var orderID: String?
    var message: String?
}

// {
//     "orderID": "bec3085d-e342-49c9-983b-f68ab8ae6414",
//     "message": "Satın alma başarılı"
// }
