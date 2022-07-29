//
//  MyCartController.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit

final class MyCartController: UITableViewController {
    
    // MARK: - Properties
    
    private let CONTENT_INSET: CGFloat = 16
    
    private let viewModel: GroceriesViewModel
    
    private var groceries: [GroceryUIModel] {
        return viewModel.getMyCartGroceries()
    }
    
    // MARK: - Views
    
    private let activityIndicatorView = ActivityIndicatorView(size: .pt30, tintColor: .tintSecondary)
    
    // MARK: - Life Cycle
    
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
        
        setupNavigationBar()
        setupTableView()
        setupActivityIndicatorView()
        
        viewModel.myCartDelegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "My Cart"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let leftButton = UIButton(
            title: "Delete All",
            titleColor: Color.tintRed.value,
            font: .systemFont(ofSize: FontType.body1.value.size),
            target: self,
            action: #selector(handleLeftBarButtonItem)
        )
        
        navigationItem.leftBarButtonItem = .init(customView: leftButton)
        
        let rightButton = UIButton(
            title: "Done",
            titleColor: Color.tintBlue.value,
            font: .systemFont(ofSize: FontType.body1.value.size),
            target: self,
            action: #selector(handleRightBarButtonItem)
        )
        
        navigationItem.rightBarButtonItem = .init(customView: rightButton)
    }
    
    private func setupTableView() {
        tableView.alwaysBounceVertical = true
        
        tableView.registerCell(MyCartCell.self)
    }
    
    private func setupActivityIndicatorView() {
        activityIndicatorView.addCenterInSuperview(superview: view)
    }
    
    private func animate(start: Bool) {
        activityIndicatorView.animating = start
        
        if start {
            tableView.alpha = 0
        } else {
            UIView.animate(withDuration: 0.5) {
                self.tableView.alpha = 1
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

extension MyCartController {
    
    @objc
    private func handleLeftBarButtonItem() {
        viewModel.removeAllGroceries()
    }
    
    @objc
    private func handleRightBarButtonItem() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MyCartController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as MyCartCell
        
        if let grocery = groceries[safe: indexPath.row] {
            cell.set(grocery: grocery)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MyCartController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - GroceriesViewModelMyCartDelegate

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
