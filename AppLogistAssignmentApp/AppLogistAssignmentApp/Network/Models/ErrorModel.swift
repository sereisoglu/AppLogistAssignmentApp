//
//  ErrorModel.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation

struct ErrorModel: Decodable, Error {
    var key: String?
    var statusCode: Int?
    var title: String?
    var message: String?
}
