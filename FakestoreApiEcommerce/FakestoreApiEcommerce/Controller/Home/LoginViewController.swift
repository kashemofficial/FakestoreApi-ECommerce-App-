//
//  LoginViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 24/12/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    //let loginResponse = [LoginResponse]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        editing()
    }
    
    func editing(){
        userNameTextField.text = "kminchelle"  //hbingley1
        passwordTextField.text = "0lelplR"     //CQutx25i8r
        
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
        ValidationCode()
        
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
                            
                            if let _ = loginResponse.token, let _ = loginResponse.username {
                                Utility.userLoggedIn(true)
                                
                                // profile image
                                
                                if let profileUrl = loginResponse.image {
                                    Utility.setUserImage(profileUrl)
                                    print(profileUrl)
                                }
                                
                                // profile username
                                
                                if let profileName = loginResponse.username{
                                    Utility.setUserName(profileName)
                                    print(profileName)
                                }
                                
                                // profile BirthDay
                                
                                if let profileBirthDay = loginResponse.birthDate{
                                    Utility.setUserBirthDay(profileBirthDay)
                                    print(profileBirthDay)
                                }
                                
                                // profile Phone Number
                                
                                if let profilePhone = loginResponse.phone{
                                    Utility.setUserPhone(profilePhone)
                                    print(profilePhone)
                                }

                                
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                            }
                            else {
                                //show error alert
                                let alert = UIAlertController(title: "User login is failed",message: "Please try again your username and password",preferredStyle: .alert)
                                let cancelAction = UIAlertAction(title: "Okay", style: .default,handler: nil)
                                alert.addAction(cancelAction)
                                self.present(alert,animated: true)
                            }
                        }
                        catch _ {
                            //show error alert
                            
                        }
                    }
                    else {
                        //show error alert
                        let alert = UIAlertController(title: "something went wrong",message: "Please try again",preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Okay", style: .default,handler: nil)
                        alert.addAction(cancelAction)
                        self.present(alert,animated: true)
                        
                    }
                }
            }
        }
    }
}

extension LoginViewController {
    fileprivate func ValidationCode(){
        if userNameTextField.text == ""{
              // Alert
            let optionMenu = UIAlertController(title: nil, message: "Please Enter UserName",preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
        }
        else if passwordTextField.text == ""{
            let optionMenu = UIAlertController(title: nil, message: "Please Enter Password", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Okay", style: .cancel, handler:
                  nil)
              optionMenu.addAction(cancelAction)
            self.present(optionMenu, animated: true, completion: nil)
        }

    }
}


//MARK: Password ValidationCode
    
//extension LoginViewController{
//        fileprivate func ValidationCode() {
//            if let username = userNameTextField.text == "", let password = passwordTextField.text {
//                if !username.validateUsername(){
//                    openAlert(title: "Alert",
//                              message: "Please enter Your Username",
//                              alertStyle: .alert,
//                              actionTitles: ["Okay"],
//                              actionStyles: [.default],
//                              actions: [{ _ in
//                        print("Okay Clicked!")
//                    }])
//
//                }else if !password.validatePassword(){
//                    openAlert(title: "Alert",
//                              message: "Please enter valid password",
//                              alertStyle: .alert,
//                              actionTitles: ["Okay"],
//                              actionStyles: [.default],
//                              actions: [{ _ in
//                        print("Okay Clicked!")
//                    }])
//                }else{
//                    //
//                }
//            }
//            else{
//                openAlert(title: "Alert",
//                          message: "Please add Detail.",
//                          alertStyle: .alert,
//                          actionTitles: ["Okay"],
//                          actionStyles: [.default],
//                          actions: [{ _ in
//                    print("Okay Clicked!")
//                }])
//            }
//        }
//    }
//
    
    
    
    
    
    
    
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
    
    

