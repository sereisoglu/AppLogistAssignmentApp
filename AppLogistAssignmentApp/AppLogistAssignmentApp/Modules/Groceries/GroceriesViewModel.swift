//
//  GroceriesViewModel.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation

protocol GroceriesViewModelDelegate: AnyObject {
    
    func setGroceries()
    func setError(error: ErrorModel)
}

final class GroceriesViewModel {
    
    private let service = APIService.shared
    
    private var groceries = [GroceryModel]()
    
    weak var delegate: GroceriesViewModelDelegate?
    
    func fetchGroceries() {
        service.request(
            endpoint: .list
        ) { [weak self ](result: Result<[GroceryModel]?, ErrorModel>) in
            switch result {
            case .success(let groceries):
                self?.groceries = groceries ?? []
                self?.delegate?.setGroceries()
                
            case .failure(let error):
                self?.delegate?.setError(error: error)
            }
        }
    }
    
    func getGroceries() -> [GroceryModel] {
        return groceries
    }
}
