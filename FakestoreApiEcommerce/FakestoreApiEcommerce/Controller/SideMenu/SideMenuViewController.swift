//
//  SideMenuViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 28/12/22.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var headerProfileImage: UIImageView!
    @IBOutlet weak var headerProfileName: UILabel!
    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var sideMenuButton: UIButton!
    
    var btnMenu : UIButton!
    
    //Delegate of the MenuVC
    
    var delegate : SlideMenuDelegate?
    
    var sideMenuData:[SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "cube.box")!, title:"Products"),
        SideMenuModel(icon: UIImage(systemName: "person")!, title: "Profile"),
        SideMenuModel(icon: UIImage(systemName: "cart")!, title: "Carts"),
        SideMenuModel(icon: UIImage(systemName: "dollarsign")!, title: "Payment")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuTableView.backgroundColor = .lightGray
        sideMenuTableViewSetup()
        headerProfile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    @IBAction func onClickSideMenuClose(_ button: UIButton) {
        btnMenu.tag = 1
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.sideMenuButton){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParent()
        })
        
    }
    
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        logOutEveryThing()
    }
    
    func headerProfile(){
        headerProfileImage.layer.cornerRadius = headerProfileImage.frame.width/2
        headerProfileImage.layer.borderWidth = 1
        headerProfileImage.layer.borderColor = CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1)
        if let profilUrl = Utility.getUserImage(){
            headerProfileImage.sd_setImage(with: URL(string: profilUrl))
        }
        
        if let profileName = Utility.getUserName(){
            headerProfileName.text = profileName
        }
    }

    
//    @objc func handleTapDismission(recognizer: UIGestureRecognizer) {
//        sideMenuDismiss()
//    }

    func sideMenuDismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: LogoutButton
    
    @objc func logOutEveryThing(){
        let app = UIApplication.shared.delegate as! AppDelegate
        app.logout()
    }
    
    func sideMenuTableViewSetup(){
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        let nib = UINib(nibName: "SideMenuTableViewCell", bundle: nil)
        sideMenuTableView.register(nib, forCellReuseIdentifier: "sideMenuCell")
        self.sideMenuTableView.reloadData()
    }

}

extension SideMenuViewController: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as! SideMenuTableViewCell
        cell.sideMenuImageView.image = sideMenuData[indexPath.row].icon
        cell.sideMenuLabel.text = sideMenuData[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.onClickSideMenuClose(btn)
    }
   
    
}





//        let cell = tableView.cellForRow(at: indexPath) as! SideMenuTableViewCell

//        switch indexPath.row {
//        case 0:
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let productVC = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
//            present(productVC, animated: true, completion: nil)
    
//            let storyboradName = UIStoryboard(name: "Main", bundle: nil)
//            let vc = storyboradName.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
//            self.navigationController?.pushViewController(vc, animated: true)
    
//        case 1:
//            let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//            self.navigationController?.pushViewController(profileVC, animated: true)
//
//        case 2:
//            let cartsVC = self.storyboard?.instantiateViewController(withIdentifier: "CartAddViewController") as! CartAddViewController
//            self.navigationController?.pushViewController(cartsVC, animated: true)
//
//        case 3:
//            let paymentVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
//            self.navigationController?.pushViewController(paymentVC, animated: true)
//        default:
//            break
//        }
//    }



