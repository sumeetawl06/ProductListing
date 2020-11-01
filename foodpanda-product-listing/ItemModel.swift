//
//  ItemModel.swift
//  foodpanda-product-listing
//
//  Created by Sumeet Agarwal on 1/11/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import Foundation

struct ItemModel: Codable {
    
    var id: Float?
    var name: String?
    var price: Float?
    var image_url: String?
    var stockAmount: Int?
    var max_per_order: Int?
    
    enum codingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case price = "price"
        case image_url = "image_url"
        case stockAmount = "stockAmount"
        case max_per_order = "max_per_order"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: codingKeys.self)
        id = try values.decodeIfPresent(Float.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        price = try values.decodeIfPresent(Float.self, forKey: .price)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        stockAmount = try values.decodeIfPresent(Int.self, forKey: .stockAmount)
        max_per_order = try values.decodeIfPresent(Int.self, forKey: .max_per_order)
    }
}
