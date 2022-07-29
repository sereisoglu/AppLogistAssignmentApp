//
//  Encodable+Extension.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation

extension Encodable {
    var toJSON: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        
        return (try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments)
        ).flatMap { $0 as? [String: Any] }
    }
}
