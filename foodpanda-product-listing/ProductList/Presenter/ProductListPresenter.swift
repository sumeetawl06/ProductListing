//
//  ProductListPresenter.swift
//  foodpanda-product-listing
//
//  Created by Sumeet Agarwal on 1/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation

class ProductListPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    var interactor: PresenterToInteractorProtocol?
    var router: PresenterToRouterProtocol?
    func fetchProductsList() {
        interactor?.fetchProductList()
    }
    
    func updateProductItemModel(operation: Operation, itemId: Float) -> (ItemModel?, Float)? {
        return interactor?.updateProductItemModel(operation: operation, itemId: itemId)
    }
}

extension ProductListPresenter: InteractorToPresenterProtocol {

    func productListFetched(productList: [ItemModel]) {
        view?.showProducts(productsList: productList)
    }

    func productListFetchFailed() {
        view?.showError()
    }
}

