//
//  ProductListProtocol.swift
//  foodpanda-product-listing
//
//  Created by Sumeet Agarwal on 1/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class {
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func fetchProductsList()
    func updateProductItemModel(operation: Operation, itemId: Float) -> (ItemModel?, Float)?
}

protocol PresenterToViewProtocol: class {
    func showProducts(productsList:[ItemModel])
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> ProductListViewController
    func addViewOnWindow(window: UIWindow)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    var dataWorker: DataWorker? {get set}
    func fetchProductList()
    func updateProductItemModel(operation: Operation, itemId: Float) -> (ItemModel?, Float)?
}

protocol InteractorToPresenterProtocol: class {
    func productListFetched(productList:[ItemModel])
    func productListFetchFailed()
}

protocol DataWorkerToInteractor: class {
    func productListFetched(productList:[ItemModel])
    func productListFetchFailed()
}


