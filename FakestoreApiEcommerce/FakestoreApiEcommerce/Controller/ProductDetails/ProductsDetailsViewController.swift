//
//  ProductsDetailsViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 30/11/22.
//

import UIKit

class ProductsDetailsViewController: UIViewController {
    
    @IBOutlet weak var producTImage: UIImageView!
    @IBOutlet weak var producTTitle: UILabel!
    @IBOutlet weak var producTDescription: UILabel!
    @IBOutlet weak var producTCategory: UILabel!
    @IBOutlet weak var producTPrice: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    
    var pImage = ""
    var pTitle = ""
    var pDescription = ""
    var pCategory = ""
    var pPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configus()
    }
    
    func configus(){
        producTImage.sd_setImage(with: URL(string: pImage))
        producTTitle.text = pTitle
        producTDescription.text = pDescription
        producTCategory.text = pCategory
        producTPrice.text = pPrice
        buyNowButton.layer.cornerRadius = 10

    }
          
    @IBAction func buyButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }

}
