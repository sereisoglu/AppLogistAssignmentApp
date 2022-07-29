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

// {
//     "id": "5f52348e919ff34aed98d349",
//     "name": "Elma",
//     "price": 6.99,
//     "currency": "₺",
//     "imageUrl": "https://desolate-shelf-18786.herokuapp.com/images/elma.png",
//     "stock": 5
// }
