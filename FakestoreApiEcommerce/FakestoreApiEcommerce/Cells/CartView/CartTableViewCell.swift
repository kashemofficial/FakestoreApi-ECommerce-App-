//
//  CartTableViewCell.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 6/12/22.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productCartImage: UIImageView!
    @IBOutlet weak var productCartTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func cartConfigure(product: ProductModel) {
        if let imagePath = product.image {
            productCartImage.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder-image"))
        }
        else {
            productCartImage.image =  UIImage(named: "placeholder-image")
        }
        productCartTitle.text = product.title
    }
    
}
