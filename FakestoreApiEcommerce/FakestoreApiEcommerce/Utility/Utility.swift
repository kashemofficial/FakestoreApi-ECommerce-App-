//
//  Utility.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 3/12/22.
//

import Foundation
import UIKit

class Utility : NSObject{

    func simpleAlert(vc: UIViewController,title: String,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default,handler: nil)
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
}
