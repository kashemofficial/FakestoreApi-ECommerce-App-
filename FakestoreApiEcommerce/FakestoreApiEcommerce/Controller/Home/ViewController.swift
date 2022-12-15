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
    
    @IBAction func buttonSignInTapped(_ sender: UIButton) {
        if let userName = userNameTextField.text, let passWord = passwordTextField.text {
            
            ProgressHUD.show()
            ValidationCode()

            let url = URL(string: "https://dummyjson.com/auth/login")
            guard url != nil else{
                print("Error")
                return
            }
            var request = URLRequest(url: url!,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10)
            let headers = ["Content-Type" : "application/json"]
            
            request.allHTTPHeaderFields = headers
            request.httpMethod = "POST"
            
            let requestObject = ["username": userName,
                                 "password": passWord ]
            
            do {
                let requestBody = try JSONSerialization.data(withJSONObject: requestObject, options: .fragmentsAllowed)
                request.httpBody = requestBody
            } catch{
                print("error")
            }
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request){data,responce,error in
                //json parsing
                
                do{
                    if let jsonParsing = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        print(jsonParsing)
                        
                        if (jsonParsing["username"] != nil) || (jsonParsing["password"] != nil) {
                            DispatchQueue.main.async { [self] in
                                ProgressHUD.dismiss()
                                let vc = storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
                                vc.modalPresentationStyle = .fullScreen
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }else{
                            DispatchQueue.main.async { [self] in  //when username and password doesn't match
                                ProgressHUD.dismiss()
                                // show error pop up message
                            }
                        }
                    }else{ // date is emapty
                        
                    }
                }catch{
                    print("Parsing Error")
                }
            }
            dataTask.resume()
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











