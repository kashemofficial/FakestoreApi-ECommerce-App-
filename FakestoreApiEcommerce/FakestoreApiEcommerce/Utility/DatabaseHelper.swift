//
//  DatabaseHelper.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 3/2/23.
//

import UIKit
import CoreData

protocol CartViewModelDelegate {
    func displayCartCount(number: Int)
}

class DatabaseHelper: NSObject {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var cartView: CartViewModelDelegate?
    
    var cartItems: [Product]? {
        didSet {
            delegate?.displayView()
        }
    }
    
    var delegate: ProductViewPresentor?
    
    func setupView(view: ProductViewPresentor) {
        delegate = view
        self.cartItems = fetchCart()
    }
    
    func addToCart(item: ProductModel) {
        let context  = appDelegate.persistentContainer.viewContext
        let itemCart = Product(context: context)
        itemCart.itemTitle = item.title
        itemCart.id = NSDecimalNumber(integerLiteral: item.id ?? 0)
        itemCart.url = item.image
        do {
          try context.save()
          print("save done")
         let item = fetchCart()
         print(item!)
        }
        catch let error as NSError {
           print(error)
        }
    }
    
    func deleteToCart(identifer: Product) {
        let context  = appDelegate.persistentContainer.viewContext
        
        do {
            context.delete(identifer)
            try context.save()
            _ = fetchCart()
        }
        catch let error as NSError {
           print(error)
        }
    }
    
   func fetchCart() -> [Product]? {
        let context  = appDelegate.persistentContainer.viewContext
        let itemCartRequest = Product.fetchRequest()
        do {
            let result = try context.fetch(itemCartRequest)
            DispatchQueue.main.async { [self] in
            cartItems = result
            cartView?.displayCartCount(number: result.count)
            }
            return result
        }
        catch {
            print("Fail")
        }
        return nil
    }
    
    
}
