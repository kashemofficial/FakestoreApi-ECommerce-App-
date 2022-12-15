//
//  ProductTableViewCell.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 30/11/22.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productId: UILabel!
    
    @IBOutlet weak var addToCart: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(product: ProductModel) {
        addToCart.layer.cornerRadius = addToCart.frame.width / 2
        if let imagePath = product.image {
            productImage.sd_setImage(with: URL(string: imagePath), placeholderImage: UIImage(named: "placeholder-image"))
        }
        else {
            productImage.image =  UIImage(named: "placeholder-image")
        }
        productId.text = String(product.id!)
        productTitle.text = product.title
        productCategory.text = product.category?.rawValue
        productPrice.text = "$" + String(product.price!)
        
    }
    
}
