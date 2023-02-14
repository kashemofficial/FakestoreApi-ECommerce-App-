//
//  ProfileViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 30/12/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileUserName: UILabel!
    @IBOutlet weak var profileUserBirthDate: UILabel!
    @IBOutlet weak var profileUserPhone: UILabel!
    
    let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftBarButtonEdit()
        profileSetUp()
    }
    func profileSetUp(){
//        profileUserName.text = loginResponse.maidenName?.description
//        profileUserBirthDate.text = loginResponse[0].birthDate
//        profileUserPhone.text = loginResponse[0].phone
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1)
        
        if let profilUrl = Utility.getUserImage(){
            profileImageView.sd_setImage(with: URL(string: profilUrl))
        }

        if let profileNameUrl = Utility.getUserName(){
            self.profileUserName.text = profileNameUrl
        }
        
        if let profileBirthDayUrl = Utility.getUserBirthDay(){
            self.profileUserBirthDate.text = profileBirthDayUrl
        }
        
        if let profilePhoneUrl = Utility.getUserPhone(){
            self.profileUserPhone.text = profilePhoneUrl
        }
        
    }
    
    func leftBarButtonEdit(){
        title = "Profile"
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
    
}
