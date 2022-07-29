//
//  GroceriesViewModel.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import Foundation

protocol GroceriesViewModelDelegate: AnyObject {
    
    func fetchGroceriesSuccess()
    func fetchGroceriesFailure(error: ErrorModel)
    
    func reload()
}

protocol GroceriesViewModelMyCartDelegate: AnyObject {
    
    func postProductsSuccess(data: CheckoutResponseModel)
    func postProductsFailure(error: ErrorModel)
    
    func reload()
}

final class GroceriesViewModel {
    
    private let service = APIService.shared
    
    private var groceries = [GroceryUIModel]()
    
    weak var delegate: GroceriesViewModelDelegate?
    
    weak var myCartDelegate: GroceriesViewModelMyCartDelegate?
    
    // Grocery
    
    func fetchGroceries() {
        service.request(
            endpoint: .list
        ) { [weak self] (result: Result<[GroceryModel]?, ErrorModel>) in
            switch result {
            case .success(let groceries):
                self?.prepareGroceries(groceries: groceries ?? [])
                self?.delegate?.fetchGroceriesSuccess()
                
            case .failure(let error):
                self?.delegate?.fetchGroceriesFailure(error: error)
            }
        }
    }
    
    func getGroceries() -> [GroceryUIModel] {
        return groceries
    }
    
    private func prepareGroceries(groceries: [GroceryModel]) {
        self.groceries = groceries.compactMap { grocery in
            guard let id = grocery.id,
                  let name = grocery.name,
                  let price = grocery.price,
                  let currency = grocery.currency,
                  let stock = grocery.stock else {
                return nil
            }
            
            return .init(
                id: id,
                imageUrl: grocery.imageUrl,
                name: name,
                price: String(format: "\(currency)%.02f", price),
                stock: stock,
                amount: 0
            )
        }
    }
    
    // My Cart
    
    func getMyCartGroceries() -> [GroceryUIModel] {
        return groceries.filter({ $0.amount > 0 })
    }
    
    func addGrocery(id: String) {
        guard let index = groceries.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        let stock = groceries[index].stock
        
        guard stock > 0 else {
            return
        }
        
        let amount = groceries[index].amount
        
        groceries[index].stock = stock - 1
        groceries[index].amount = amount + 1
        
        delegate?.reload()
        myCartDelegate?.reload()
    }
    
    func removeGrocery(id: String) {
        guard let index = groceries.firstIndex(where: { $0.id == id }) else {
            return
        }
        
        let amount = groceries[index].amount
        
        guard amount > 0 else {
            return
        }
        
        let stock = groceries[index].stock
        
        groceries[index].amount = amount - 1
        groceries[index].stock = stock + 1
        
        delegate?.reload()
        myCartDelegate?.reload()
    }
    
    func removeAllGroceries() {
        groceries = groceries.map { grocery in
            return .init(
                id: grocery.id,
                imageUrl: grocery.imageUrl,
                name: grocery.name,
                price: grocery.price,
                stock: grocery.stock + grocery.amount,
                amount: 0
            )
        }
        
        delegate?.reload()
        myCartDelegate?.reload()
    }
    
    func postProducts() {
        let products: [ProductModel] = groceries.compactMap { grocery in
            guard grocery.amount > 0 else {
                return nil
            }
            
            return .init(id: grocery.id, amount: grocery.amount)
        }
        
        service.request(
            endpoint: .checkout(products: .init(products: products))
        ) { [weak self] (result: Result<CheckoutResponseModel?, ErrorModel>) in
            switch result {
            case .success(let data):
                if let data = data {
                    self?.myCartDelegate?.postProductsSuccess(data: data)
                } else {
                    self?.myCartDelegate?.postProductsFailure(error: .init(
                        error: "Nil Response"
                    ))
                }
                
            case .failure(let error):
                self?.myCartDelegate?.postProductsFailure(error: error)
            }
        }
    }
}
