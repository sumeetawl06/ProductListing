//
//  ViewController.swift
//  foodpanda-product-listing
//
//  Created by Shahin Gharebaghi on 27/10/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    
    var presentor:ViewToPresenterProtocol?
    
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray = [ItemModel]()
    
    @IBOutlet weak var totalAmountLabel: UILabel!
    var totalVariable:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        presentor?.fetchProductsList()

    }
    
    //MARK: Event Handling
    
    func updateTotalCountOnPlusClick(cell: ItemCollectionViewCell) {
        cell.addedCount = cell.addedCount + 1
        cell.itemCountTextField.text = "\(String(describing: cell.addedCount))"
        self.totalVariable = self.totalVariable + (cell.data?.price ?? 0)
        self.totalAmountLabel.text = "Total Price: $\(self.totalVariable)"
    }
    
    func handlePlusButtonClick(cell: ItemCollectionViewCell) {
        if (cell.data?.stockAmount == -1 && cell.data?.max_per_order == -1) {
            self.updateTotalCountOnPlusClick(cell: cell)
            return
        }
        if let maxPO = cell.data?.max_per_order, let stock = cell.data?.stockAmount, cell.addedCount < maxPO && cell.addedCount < stock {
            self.updateTotalCountOnPlusClick(cell: cell)
        }
    }
    
    func updateTotalCountOnMinusClick(cell: ItemCollectionViewCell) {
        cell.addedCount = cell.addedCount - 1
        cell.itemCountTextField.text = "\(String(describing: cell.addedCount))"
        self.totalVariable = self.totalVariable - (cell.data?.price ?? 0)
        self.totalAmountLabel.text = "Total Price: $\(self.totalVariable)"
    }
    
}

extension ProductListViewController:PresenterToViewProtocol {
    func showProducts(productsList: [ItemModel]) {
        dataArray = productsList
        collectionView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Reading JSON file", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.resetData()
        cell.data = dataArray[indexPath.item]
        
        cell.plusButtonClick = { cell in
            self.handlePlusButtonClick(cell: cell)
        }
        
        cell.minusButtonClick = { cell in
            if cell.addedCount > 0 {
                self.updateTotalCountOnMinusClick(cell: cell)
            }
            print("Minus Button Clicked")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width)/2, height: (collectionView.frame.size.height - 100)/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    }
}
