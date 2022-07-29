//
//  MyCartController.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/29/22.
//

import UIKit
import LBTATools

final class MyCartController: UITableViewController {
    
    // MARK: - Properties
    
    private let CONTENT_INSET: CGFloat = 16
    
    private let viewModel: GroceriesViewModel
    
    private var groceries: [GroceryUIModel] {
        return viewModel.getMyCartGroceries()
    }
    
    // MARK: - Views
    
    private let activityIndicatorView = ActivityIndicatorView(size: .pt30, tintColor: .tintSecondary)
    
    private let bottomBarView = BottomBarView()
    
    private var navigationControllerView: UIView {
        return navigationController?.view ?? view
    }
    
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
        
        navigationControllerView.backgroundColor = Color.backgroundDefault.value
        tableView.backgroundColor = Color.backgroundDefault.value
        
        setupNavigationBar()
        setupTableView()
        setupActivityIndicatorView()
        setupBottomBarView()
        
        viewModel.myCartDelegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "My Cart"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let leftButton = UIButton(
            title: "Remove All",
            titleColor: Color.tintRed.value,
            font: .systemFont(ofSize: FontType.body1.value.size),
            target: self,
            action: #selector(handleLeftBarButtonItem)
        )
        
        navigationItem.leftBarButtonItem = .init(customView: leftButton)
        
        let rightButton = UIButton(
            title: "Done",
            titleColor: Color.tintBlue.value,
            font: .boldSystemFont(ofSize: FontType.body1.value.size),
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
        activityIndicatorView.addCenterInSuperview(superview: navigationControllerView)
    }
    
    private func setupBottomBarView() {
        navigationControllerView.addSubview(bottomBarView)
        bottomBarView.anchor(
            .leading(navigationControllerView.leadingAnchor),
            .bottom(navigationControllerView.bottomAnchor),
            .trailing(navigationControllerView.trailingAnchor),
            .height(120)
        )
        
        bottomBarView.set(leftLabelText: "Total:")
        bottomBarView.set(rightLabelText: viewModel.totalPriceText)
        bottomBarView.set(buttonText: "Place Order")
        
        bottomBarView.delegate = self
    }
    
    private func updateBottomBarView() {
        bottomBarView.set(rightLabelText: viewModel.totalPriceText)
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
        let alertController = UIAlertController(
            title: "Remove All!",
            message: "Are you sure you want to remove all groceries? This action cannot be undone.",
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: "Remove",
                style: .destructive,
                handler: { [weak self] _ in
                    self?.viewModel.removeAllGroceries()
                }
            )
        )
        
        alertController.addAction(
            UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc
    private func handleRightBarButtonItem() {
        dismiss(animated: true)
    }
}

// MARK: - Navigate & Present

extension MyCartController {
    
    private func presentAlertController(
        title: String,
        message: String
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(title: "OK", style: .default)
        )
        
        present(alertController, animated: true, completion: nil)
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
            cell.set(grocery: grocery, index: indexPath.row, delegate: self)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MyCartController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - GroceriesViewModelMyCartDelegate

extension MyCartController: GroceriesViewModelMyCartDelegate {
    
    func postProductsSuccess(data: CheckoutResponseModel) {
        animate(start: false)
        
        viewModel.removeAllGroceries()

        presentAlertController(
            title: "Success!",
            message: data.message ?? "Your order has been completed successfully."
        )
    }
    
    func postProductsFailure(error: ErrorModel) {
        animate(start: false)
        
        presentAlertController(
            title: "API Error!",
            message: error.error ?? "An unknown error has occurred."
        )
    }
    
    func reload() {
        updateBottomBarView()
        
        tableView.reloadData()
    }
}

// MARK: StepperViewDelegate

extension MyCartController: StepperViewDelegate {
    
    func handleMinusButton(index: Int) {
        guard let id = groceries[safe: index]?.id else {
            return
        }
        
        viewModel.removeGrocery(id: id)
    }
    
    func handlePlusButton(index: Int) {
        guard let id = groceries[safe: index]?.id else {
            return
        }
        
        viewModel.addGrocery(id: id)
    }
}

// MARK: - BottomBarViewDelegate

extension MyCartController: BottomBarViewDelegate {
    
    func handleButton() {
        animate(start: true)
        
        viewModel.postGroceries()
    }
}
