//
//  foodpanda_product_listingTests.swift
//  foodpanda-product-listingTests
//
//  Created by Shahin Gharebaghi on 27/10/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import XCTest
@testable import foodpanda_product_listing

class foodpanda_product_listingTests: XCTestCase {

    var dataWorker = DataWorker()
    
    override func setUp() {
        super.setUp()
        dataWorker.fetchProductList()
    }
    
    func testMaxPerOrderCondition() {
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 1)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 1)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 1)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 1)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 1)
        let result = dataWorker.updateProductItemModel(operation: .Add, itemId: 1)
        XCTAssertTrue(result?.0?.quantity_added == 2, "Quantity added exceeds the Max Per Order.")
    }
    
    func testStockCondition() {
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 7)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 7)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 7)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 7)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 7)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 7)
        let result = dataWorker.updateProductItemModel(operation: .Add, itemId: 7)
        XCTAssertTrue(result?.0?.quantity_added == 6, "Quantity added exceeds the Stock amount.")
    }
    
    func testUnlimitedCondition() {
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        _ = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        let result = dataWorker.updateProductItemModel(operation: .Add, itemId: 6)
        XCTAssertTrue(result?.0?.quantity_added == 11, "When stock_amount and max_per_order is -1 then any number of items can be added.")
    }
        
    func testStockAmountZero() {
        dataWorker.interactor = self
        dataWorker.fetchProductList()
        
    }

}

extension foodpanda_product_listingTests: DataWorkerToInteractor {
    func productListFetched(productList: [ItemModel]) {
        XCTAssertNil(productList.first ( where: { $0.stockAmount == 0 }), "Products for stock amount zero is shown")
    }
    
    func productListFetchFailed() {
        
    }
    
    
}
