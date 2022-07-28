//
//  GroceriesController.swift
//  AppLogistAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 7/28/22.
//

import UIKit

final class GroceryCell: UICollectionViewCell {
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    func setData() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class GroceriesController: UICollectionViewController {
    
    private let SCREEN_WIDTH = UIScreen.main.bounds.width
    private let NUMBER_OF_ITEMS_IN_A_LINE = 3
    private let CONTENT_INSET: CGFloat = 16
    private let SPACE_BETWEEN_ITEMS: CGFloat = 12
    private let ASPECT_RATIO_OF_ITEMS: CGFloat = 2 / 3
    private var ITEM_SIZE: CGSize {
        let width = (SCREEN_WIDTH - (2 * CONTENT_INSET) - (CGFloat(NUMBER_OF_ITEMS_IN_A_LINE - 1) * SPACE_BETWEEN_ITEMS)) / 3
        let height = width / ASPECT_RATIO_OF_ITEMS
        return .init(width: width, height: height)
    }
    
    init() {
        let collectionViewLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: collectionViewLayout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Groceries"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        collectionView.contentInset = .init(top: CONTENT_INSET, left: CONTENT_INSET, bottom: CONTENT_INSET, right: CONTENT_INSET)
        
        collectionView.registerCell(UICollectionViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource

extension GroceriesController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GroceriesController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return ITEM_SIZE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return SPACE_BETWEEN_ITEMS
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return SPACE_BETWEEN_ITEMS
    }
}


// MARK: - UICollectionViewDelegate

extension GroceriesController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
