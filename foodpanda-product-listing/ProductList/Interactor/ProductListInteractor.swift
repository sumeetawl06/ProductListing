//
//  ProductListInteractor.swift
//  foodpanda-product-listing
//
//  Created by Sumeet Agarwal on 1/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation

class ProductListInteractor: PresenterToInteractorProtocol {
    
    var presenter: InteractorToPresenterProtocol?
    var dataWorker: DataWorker? {
        didSet {
            dataWorker?.interactor = self
        }
    }
     
    func fetchProductList() {
        dataWorker?.fetchProductList()
    }
    
    func updateProductItemModel(operation: Operation, itemId: Float) -> (ItemModel?, Float)? {
        return dataWorker?.updateProductItemModel(operation: operation, itemId: itemId)
    }
}

extension ProductListInteractor: DataWorkerToInteractor {
    
    func productListFetched(productList: [ItemModel]) {
        self.presenter?.productListFetched(productList: productList)
    }
    
    func productListFetchFailed() {
        self.presenter?.productListFetchFailed()
    }
}
