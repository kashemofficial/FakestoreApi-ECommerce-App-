//
//  ViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 30/11/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    var signInData = [LoginResponse]()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func viewDidLoad(){
        super.viewDidLoad()
        editing()
    }
    
    func editing(){
        userNameTextField.text = "kminchelle"
        passwordTextField.text = "0lelplR"
        
        emailView.layer.cornerRadius = emailView.frame.height/2
        emailView.layer.shadowColor = UIColor.black.cgColor
        emailView.layer.shadowOpacity = 0.1
        emailView.layer.shadowOffset = .zero
        emailView.layer.shadowRadius = 5
        
        passwordView.layer.cornerRadius = passwordView.frame.height/2
        passwordView.layer.shadowColor = UIColor.black.cgColor
        passwordView.layer.shadowOpacity = 0.1
        passwordView.layer.shadowOffset = .zero
        passwordView.layer.shadowRadius = 5
    }
    
    
    @IBAction func buttonSignInTapped(_ sender: UIButton) {        ValidationCode()
        if let userName = userNameTextField.text, let passWord = passwordTextField.text {
            
            ProgressHUD.show()
            
            let requestObject = ["username": userName,
                                 "password": passWord ]
            
            let service = WebService()
            service.call(with: "https://dummyjson.com/auth/login", httpMethod: "POST", httpBody: requestObject) { data in
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    
                    ProgressHUD.dismiss()
                    
                    if let data = data {
                        do {
                            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                            
                            if let token = loginResponse.token, let userName = loginResponse.username {
                                Utility.userLoggedIn(true)
                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            else {
                                //show error alert
                            }
                        }
                        catch let error {
                            //show error alert
                        }
                    }
                    else {
                        //show error alert
                    }
                }
            }
        }
    }

}

//MARK: Password ValidationCode

extension ViewController{
    fileprivate func ValidationCode() {
        if let password = passwordTextField.text{
            if !password.validatePassword(){
                openAlert(title: "Alert",
                          message: "Please enter valid password",
                          alertStyle: .alert,
                          actionTitles: ["Okay"],
                          actionStyles: [.default],
                          actions: [{ _ in
                    print("Okay Clicked!")
                }])
            }else{
                print("Yes")
            }
        }
        else{
            openAlert(title: "Alert",
                      message: "Please add Detail.",
                      alertStyle: .alert,
                      actionTitles: ["Okay"],
                      actionStyles: [.default],
                      actions: [{ _ in
                print("Okay Clicked!")
            }])
        }
    }
}













//MARK: validation

//        if(validationMethod()){
//            if let email = emailTextField.text, let pass = passwordTextField.text {
//
//            }
//        }
//MARK: validatioFunc

//    func validationMethod() -> Bool {
//        var isCheck = true
//        if let email = emailTextField.text, let password = passwordTextField.text {
//            if email == "" {
//                Utility().simpleAlert(vc: self, title: "Alert!", message: "Please Enter Email")
//                isCheck = false
//            }
//            else if password == ""{
//                Utility().simpleAlert(vc: self, title: "Alert!", message: "Please Enter Password")
//                isCheck = false
//            }
//            else if !email.isValidEmail(email: email){
//                Utility().simpleAlert(vc: self, title: "Alert!", message: "Please Enter Valid Email")
//                isCheck = false
//            }
//            else if !password.isValidPassword(password: password){
//                Utility().simpleAlert(vc: self, title: "Alert!", message: "Please Enter Valid Password")
//                isCheck = false
//            }
//        }
//        return isCheck
//    }
//}
//
//extension String{
//    func isValidEmail(email: String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        let result = emailTest.evaluate(with: email)
//        return result
//    }
//
//    func isValidPassword(password: String) -> Bool {
//        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
//        let passwordRegx = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-Z\\d$$@$#!%*?&]{6,16}"
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
//        let result = passwordTest.evaluate(with: password)
//        return result
//    }











