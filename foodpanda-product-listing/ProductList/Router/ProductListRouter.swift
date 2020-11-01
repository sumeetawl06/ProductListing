//
//  ProductListRouter.swift
//  foodpanda-product-listing
//
//  Created by Sumeet Agarwal on 1/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation
import UIKit

class ProductListRouter: PresenterToRouterProtocol {
    
    static func createModule() -> ProductListViewController {
        let view = productStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ProductListViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = ProductListPresenter()
        let interactor: PresenterToInteractorProtocol = ProductListInteractor()
        let router:PresenterToRouterProtocol = ProductListRouter()
        let dataWorker = DataWorker()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.dataWorker = dataWorker
        
        return view
    }
    
    static var productStoryboard: UIStoryboard {
        return UIStoryboard(name:"Product",bundle: Bundle.main)
    }

    
    func addViewOnWindow(window: UIWindow) {
        
    }
}
