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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        presentor?.fetchProductsList()
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
    
    func performAddRemove(operation: Operation, itemId: Float, itemX: Int) {
        
        guard let result = self.presentor?.updateProductItemModel(operation: operation, itemId: itemId), let updatedItem = result.0 else {
            return
        }
        self.dataArray[itemX] = updatedItem
        self.totalAmountLabel.text = "Total Price: $\(result.1)"
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemCollectionViewCell
        cell.resetData()
        let item = dataArray[indexPath.item]
        cell.data = item
        cell.plusButtonClick = { cell in
            
            self.performAddRemove(operation: .Add, itemId: item.id ?? 0, itemX: indexPath.item)
            cell.data = self.dataArray[indexPath.item]
            collectionView.reloadItems(at: [indexPath])
        }
        
        cell.minusButtonClick = { cell in
            if let qntyAdded = cell.data?.quantity_added, qntyAdded > 0 {
                self.performAddRemove(operation: .Substract, itemId: item.id ?? 0, itemX: indexPath.item)
                cell.data = self.dataArray[indexPath.item]
                collectionView.reloadItems(at: [indexPath])
            }
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
