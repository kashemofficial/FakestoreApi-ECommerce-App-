//
//  CartAddViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 6/12/22.
//

import UIKit

//protocol CurrentCatNumber {
//    func getNumber(_ num: Int)
//}

class CartAddViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedItems = [ProductModel]()
   // var delegate: CurrentCatNumber?
    var viewModel = DatabaseHelper()
    let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPTableViewCell()
        leftBarButtonEdit()
        viewModel.setupView(view: self)
    }
    
    func leftBarButtonEdit(){
        title = "All Cart List"
        leftButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        leftButton.contentVerticalAlignment = .fill
        leftButton.contentHorizontalAlignment = .fill
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 15)
    
        leftButton.tintColor = .orange
        leftButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = leftButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setUPTableViewCell() {
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension CartAddViewController: UITableViewDelegate, UITableViewDataSource,ProductViewPresentor {
    
    func displayCartCount(number: Int) {
        
    }
    
    func displayView() {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return selectedItems.count
        return viewModel.cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
       // cell.cartConfigure(product: selectedItems[indexPath.row])
        
        cell.productCartTitle?.text = viewModel.cartItems?[indexPath.row].itemTitle ?? ""
        let url = viewModel.cartItems?[indexPath.row].url ?? ""
        cell.productCartImage?.sd_setImage(with: URL(string: url)!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          if let id = viewModel.cartItems?[indexPath.row] {
            viewModel.deleteToCart(identifer: id)
            }
        }
    }
    
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let Delete = selectedItems[indexPath.row]
//
//        //MARK: cell delete Action
//
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){(action, indexPath) in
//            self.deleteAction(updateDelete: Delete, indexPath: indexPath)
//        }
//        deleteAction.backgroundColor = .red
//        return[deleteAction]
//    }
//
//    //MARK: deleteAction success
//
//    func deleteAction(updateDelete: ProductModel, indexPath: IndexPath){
//        let alert = UIAlertController(title: "Delete",message: "are you sure your information deletion?",preferredStyle: .alert)
//        let deleteAction = UIAlertAction(title: "Yes",
//                                         style: .default){(action) in
//            self.selectedItems.remove(at: indexPath.row)
//            self.tableView?.deleteRows(at: [indexPath], with: .automatic)
//           // addToCart = self.selectedItems  //remove reload cart list
//
//            if let delegate = self.delegate {
//                delegate.getNumber(self.selectedItems.count)
//            }
//        }
//        let cancelAction = UIAlertAction(title: "No", style: .default,handler: nil)
//        alert.addAction(deleteAction)
//        alert.addAction(cancelAction)
//        present(alert,animated: true)
//    }
}


