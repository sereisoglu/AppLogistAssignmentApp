//
//  MyCartController.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

final class MyCartController: UITableViewController {
    
    private let viewModel: GroceriesViewModel
    
    init(viewModel: GroceriesViewModel) {
        self.viewModel = viewModel
        
        if #available(iOS 13.0, *) {
            super.init(style: .insetGrouped)
        } else {
            super.init(style: .grouped)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.backgroundDefault.value
        tableView.backgroundColor = Color.backgroundDefault.value
        tableView.alwaysBounceVertical = true
        
        navigationItem.title = "My Cart"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let label = Label(text: "Delete All", type: .body1, weight: .medium, color: .tintRed, alignment: .center)
        navigationItem.leftBarButtonItem = .init(customView: label)
        
        let label2 = Label(text: "Done", type: .body1, weight: .medium, color: .tintBlue, alignment: .center)
        navigationItem.rightBarButtonItem = .init(customView: label2)
        
        viewModel.myCartDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyCartController: GroceriesViewModelMyCartDelegate {
    
    func postProductsSuccess(data: CheckoutResponseModel) {
        tableView.reloadData()
    }
    
    func postProductsFailure(error: ErrorModel) {
        
    }
    
    func reload() {
        tableView.reloadData()
    }
}
