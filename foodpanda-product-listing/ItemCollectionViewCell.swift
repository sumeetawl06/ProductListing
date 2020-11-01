//
//  ItemCollectionViewCell.swift
//  foodpanda-product-listing
//
//  Created by Sumeet Agarwal on 31/10/20.
//  Copyright © 2020 foodpanda. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var itemCountTextField: UITextField!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    var addedCount: Int = 0
    
    var plusButtonClick: ((ItemCollectionViewCell) -> ())?
    var minusButtonClick: ((ItemCollectionViewCell) -> ())?
    
    var data: ItemModel? {
        didSet {
            setDataInCell()
        }
    }
    
    func resetData() {
        productImageView.image = nil
        itemCountTextField.text = "0"
        productNameLabel.text = ""
    }
    
    func setDataInCell() {
        productImageView.sd_setImage(with: URL(string: data?.image_url ?? ""), placeholderImage: UIImage(named: ""))
        productPriceLabel.text = "\(data?.price ?? 0)"
        productNameLabel.text = data?.name ?? ""
        itemCountTextField.text = "\(addedCount)"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func minusButtonClicked(_ sender: Any) {
        minusButtonClick?(self)
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        plusButtonClick?(self)
    }
}
