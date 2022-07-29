//
//  GroceriesController.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/28/22.
//

import UIKit
import LBTATools

final class GroceriesController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let SCREEN_WIDTH = UIScreen.main.bounds.width
    private let NUMBER_OF_ITEMS_IN_A_LINE = 3
    private let CONTENT_INSET: CGFloat = 16
    private let SPACE_BETWEEN_ITEMS_HORIZONTAL: CGFloat = 12
    private let SPACE_BETWEEN_ITEMS_VERTICAL: CGFloat = 20
    private lazy var ITEM_SIZE: CGSize = {
        let width = (SCREEN_WIDTH - (2 * CONTENT_INSET) - (CGFloat(NUMBER_OF_ITEMS_IN_A_LINE - 1) * SPACE_BETWEEN_ITEMS_HORIZONTAL)) / 3
        return GroceryCell.getSize(width: width)
    }()
    
    private let viewModel = GroceriesViewModel()
    
    private var groceries: [GroceryUIModel] {
        return viewModel.getGroceries()
    }
    
    // MARK: - Views
    
    private let activityIndicatorView = ActivityIndicatorView(size: .pt30, tintColor: .tintSecondary)
    
    // MARK: - Life Cycle
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.backgroundDefault.value
        collectionView.backgroundColor = Color.backgroundDefault.value
        
        setupNavigationBar()
        setupCollectionView()
        setupActivityIndicatorView()
        
        viewModel.delegate = self
        
        animate(start: true)
        
        viewModel.fetchGroceries()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Groceries"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let rightButton = BarButtonItemWithBadge()
        rightButton.set(icon: .cart)
        rightButton.addTarget(
            self,
            action: #selector(handleRightBarButtonItem),
            for: .primaryActionTriggered
        )
        
        navigationItem.rightBarButtonItem = .init(customView: rightButton)
    }
    
    private func updateNavigationBar() {
        guard let rightButton = navigationItem.rightBarButtonItem?.customView as? BarButtonItemWithBadge else {
            return
        }
        
        rightButton.set(badgeValue: viewModel.totalAmount)
    }
    
    private func setupCollectionView() {
        collectionView.alwaysBounceVertical = true
        collectionView.contentInset = .allSides(CONTENT_INSET)
        
        collectionView.registerCell(GroceryCell.self)
    }
    
    private func setupActivityIndicatorView() {
        activityIndicatorView.addCenterInSuperview(superview: view)
    }
    
    private func animate(start: Bool) {
        activityIndicatorView.animating = start
        
        if start {
            collectionView.alpha = 0
        } else {
            UIView.animate(withDuration: 0.5) {
                self.collectionView.alpha = 1
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Actions

extension GroceriesController {
    
    @objc
    private func handleRightBarButtonItem() {
        presentToMyCartController()
    }
}

// MARK: - Navigate & Present

extension GroceriesController {
    
    private func presentToMyCartController() {
        let controller = MyCartController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true, completion: nil)
    }
    
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

// MARK: - UICollectionViewDataSource

extension GroceriesController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groceries.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as GroceryCell
        
        if let grocery = groceries[safe: indexPath.item] {
            cell.set(grocery: grocery, index: indexPath.item, delegate: self)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GroceriesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ITEM_SIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SPACE_BETWEEN_ITEMS_VERTICAL
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return SPACE_BETWEEN_ITEMS_HORIZONTAL
    }
}


// MARK: - UICollectionViewDelegate

extension GroceriesController {
}

// MARK: - GroceriesViewModelDelegate

extension GroceriesController: GroceriesViewModelDelegate {
    
    func fetchGroceriesSuccess() {
        animate(start: false)
        
        reload()
    }
    
    func fetchGroceriesFailure(error: ErrorModel) {
        animate(start: false)
        
        presentAlertController(
            title: "API Error!",
            message: error.error ?? "An unknown error has occurred."
        )
    }
    
    func reload() {
        updateNavigationBar()
        collectionView.reloadData()
    }
}

// MARK: StepperViewDelegate

extension GroceriesController: StepperViewDelegate {
    
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
