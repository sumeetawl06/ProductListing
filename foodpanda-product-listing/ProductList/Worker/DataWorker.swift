//
//  DataWorker.swift
//  foodpanda-product-listing
//
//  Created by Sumeet Agarwal on 1/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation

class DataWorker {
    
    var totalOrderAmount: Float = 0
    var interactor: DataWorkerToInteractor?
    var dataArray: [ItemModel]?
    
    func fetchProductList() {
        guard let url = Bundle.main.url(forResource: AppConstant.jsonFileName, withExtension: "json"), let data = try? Data(contentsOf: url) else {
            return
        }
        do {
            let products = try JSONDecoder().decode([ItemModel].self, from: data)
            let filtered = products.filter({ (item) -> Bool in
                return (item.stockAmount != 0)
            })
            dataArray = filtered
            self.interactor?.productListFetched(productList: dataArray ?? [])
        }
        catch {
            self.interactor?.productListFetchFailed()
        }
    }

    func updateProductItemModel(operation: Operation, itemId: Float) -> (ItemModel?, Float)? {
        
        guard var itemModel = dataArray?.first(where: { (item) -> Bool in
            item.id == itemId
        }) else {
            return (nil, totalOrderAmount)
        }
        
        let index = dataArray?.firstIndex(where: { (item) -> Bool in
            item.id == itemId
        })
        
        switch operation {
        case .Add:
            if (itemModel.stockAmount == -1 && itemModel.max_per_order == -1) {
                itemModel.quantity_added = (itemModel.quantity_added ?? 0) + 1
            }else if let maxPO = itemModel.max_per_order, let stock = itemModel.stockAmount, let quantity = itemModel.quantity_added, quantity < maxPO && quantity < stock {
                itemModel.quantity_added = (itemModel.quantity_added ?? 0) + 1
            }
        case .Substract:
            guard ((itemModel.quantity_added ?? 0) > 0) else {
                return (itemModel, totalOrderAmount)
            }
            itemModel.quantity_added = (itemModel.quantity_added ?? 0) - 1
        }
        if let index = index {
            dataArray?[index] = itemModel
        }
        totalOrderAmount = dataArray?.map({ (item) -> Float in
            let quantityAdded:Float = Float(item.quantity_added ?? 0)
            let priceOfItem: Float = item.price ?? 0
            return Float(quantityAdded * priceOfItem)
        }).reduce (Float(0.0),+) ?? 0
                
        return (itemModel, totalOrderAmount)
    }
}

enum Operation {
    case Add
    case Substract
}
