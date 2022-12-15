//
//  CartAddViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 6/12/22.
//

import UIKit

protocol CurrentCatNumber {
    func getNumber(_ num: Int)
}

class CartAddViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedItems = [ProductModel]()
    var delegate: CurrentCatNumber?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPTableViewCell()
    }
    
    func setUPTableViewCell() {
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension CartAddViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        cell.cartConfigure(product: selectedItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Delete = selectedItems[indexPath.row]
        
        //MARK: cell delete Action
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){(action, indexPath) in
            self.deleteAction(updateDelete: Delete, indexPath: indexPath)
        }
        deleteAction.backgroundColor = .red
        return[deleteAction]
    }
    
    //MARK: deleteAction success
    
    func deleteAction(updateDelete: ProductModel, indexPath: IndexPath){
        let alert = UIAlertController(title: "Delete",message: "are you sure your information deletion?",preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Yes",
                                         style: .default){(action) in
            self.selectedItems.remove(at: indexPath.row)
            self.tableView?.deleteRows(at: [indexPath], with: .automatic)
            addToCart = self.selectedItems  //reload cart
            
            if let delegate = self.delegate {
                delegate.getNumber(self.selectedItems.count)
            }
            
        }
        let cancelAction = UIAlertAction(title: "No", style: .default,handler: nil)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
}