//
//  GroceryModel.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation

struct GroceryModel: Codable {
    var id: String?
    var imageUrl: String?
    var name: String?
    var price: Double?
    var currency: String?
    var stock: Int?
}
