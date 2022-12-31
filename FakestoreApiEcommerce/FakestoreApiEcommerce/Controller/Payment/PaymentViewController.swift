//
//  PaymentViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 28/12/22.
//

import UIKit

class PaymentViewController: UIViewController {

    let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftBarButtonEdit()
    }
    
    func leftBarButtonEdit(){
        title = "Payment"
        leftButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        leftButton.contentVerticalAlignment = .fill
        leftButton.contentHorizontalAlignment = .fill
        leftButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        leftButton.tintColor = .black
        leftButton.addTarget(self, action: #selector(backButtonAction), for: UIControl.Event.touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = leftButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }

    

}
