//
//  ProductListViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 2/12/22.
//

import UIKit

var addToCart = [ProductModel]()

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    var allProducts = [ProductModel]()
    
    var cartCount = 0
    let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let cartBarButton = UIButton(type: .custom)
    let profileBarButton = UIButton(type: .custom)
    let menuBarButton = UIButton(type: .custom)
    
    var sideBarView: UIView!
    var sideBarTableView = UITableView()
    var topLabel = UILabel()
    var bottomView = UIView()
    var logOutButton = UIButton()
    var nameLabel = UILabel()
    var imageView = UIImageView()
    var topHeight_navigationBar_statusBar:CGFloat = 0.0
    var isEnableSideBarView:Bool = false
    
    var swipeToRight = UISwipeGestureRecognizer()
    var swipeToLeft = UISwipeGestureRecognizer()
    var tempView = UIView()
    var tapGesture = UITapGestureRecognizer()
    
    var sideMenuData:[SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "cube.box")!, title:"Products"),
        SideMenuModel(icon: UIImage(systemName: "person")!, title: "Profile"),
        SideMenuModel(icon: UIImage(systemName: "cart")!, title: "Carts"),
        SideMenuModel(icon: UIImage(systemName: "dollarsign")!, title: "Payment")
        
    ]
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpTableView()
        fetchData()
        showBadge()
        rightBarButtonEdit()
        
        self.badgeCount.text = String(AppData.addCart)
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        leftBarButtonEdit()
        loadSideBarViewFunctionality()
        loadGesturefunctionality()
        self.view.backgroundColor = .systemGray6
        
    }
    
    //MARK: Left BarButton
    
    func leftBarButtonEdit(){
        menuBarButton.setImage(UIImage(systemName: "text.justify"), for: .normal)
        menuBarButton.translatesAutoresizingMaskIntoConstraints = false
        menuBarButton.layer.masksToBounds = true
        menuBarButton.backgroundColor = .clear
        menuBarButton.tintColor = UIColor(cgColor:  CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        menuBarButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        menuBarButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        menuBarButton.transform = CGAffineTransformMakeScale(1.6, 1.6)
        //menuBarButton.tintColor = .systemGreen
        menuBarButton.addTarget(self, action: #selector(MenuBarButtonAction), for: UIControl.Event.touchUpInside)
        let leftBarButton1 = UIBarButtonItem(customView: menuBarButton)
        self.navigationItem.setLeftBarButtonItems([leftBarButton1], animated: false)
        
    }
    
    //MARK: load SideBar View Functionality
    
    func loadSideBarViewFunctionality(){
        // topHeight_navigationBar_statusBar = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)!
        
        tempView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        tempView.backgroundColor = .lightGray
        tempView.alpha = 0
        
        sideBarView = UIView(frame: CGRect(x: -self.view.bounds.width/1.5, y: topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - topHeight_navigationBar_statusBar))
        
        sideBarTableView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        sideBarTableView.delegate = self
        sideBarTableView.dataSource = self
        sideBarTableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideBarCell")
        sideBarTableView.separatorStyle = .none
        sideBarTableView.bounces = false
        
        
        topLabel.text = "EPS(Easy Payment System)"
        topLabel.textAlignment = .center
        topLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        topLabel.textColor = UIColor.white
        topLabel.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        
        bottomView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        logOutButton.titleLabel?.textColor = UIColor.white
        logOutButton.titleLabel?.font = UIFont(name: "Chalkboard SE", size: 20)
        logOutButton.addTarget(self, action: #selector(logOutEveryThing), for: UIControl.Event.touchUpInside)
        
        
        nameLabel.numberOfLines = 0
        nameLabel.text = "MD Abul kashem"
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        
        
        
        if let imageUrl = Utility.getUserImage(){
            imageView.sd_setImage(with: URL(string: imageUrl))
        }
        
        //imageview.image = UIImage(imageLiteralResourceName: "img1")
        self.imageView.clipsToBounds = true
        self.imageView.layer.borderWidth = 1
        self.imageView.layer.borderColor = UIColor.white.cgColor
        
        self.view.addSubview(tempView)
        self.view.addSubview(sideBarView)
        self.sideBarView.addSubview(topLabel)
        self.sideBarView.addSubview(bottomView)
        self.sideBarView.addSubview(sideBarTableView)
        
        self.bottomView.addSubview(logOutButton)
        self.bottomView.addSubview(nameLabel)
        self.bottomView.addSubview(imageView)
        
        setUpSideBarViewConstraints()
        setUpBottomViewConstraints()
    }
    
    //MARK: LogoutButton
    
    @objc func logOutEveryThing(){
        let app = UIApplication.shared.delegate as! AppDelegate
        app.logout()
    }
    // MARK: loadGesturefunctionality
    
    func loadGesturefunctionality(){
        swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedToRight))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
        
        swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
        swipeToLeft.direction = .left
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideBarView))
        tempView.addGestureRecognizer(tapGesture)
    }
    
    func setUpBottomViewConstraints(){
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20).isActive = true
        //        logOutBtn.trailingAnchor.constraint(equalTo: self.imageview.leadingAnchor, constant: -20).isActive = true
        logOutButton.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 15).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20).isActive = true
        //        nameLbl.trailingAnchor.constraint(equalTo: self.imageview.leadingAnchor, constant: -20).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -15).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.logOutButton.bottomAnchor, constant: 0).isActive = true
        
//        imageview.translatesAutoresizingMaskIntoConstraints = false
//        imageview.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 20).isActive = true
//        imageview.trailingAnchor.constraint(equalTo: self.bottomView.trailingAnchor, constant: -20).isActive = true
//        imageview.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -20).isActive = true
//        imageview.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    //MARK: setUp SideBar ViewConstraints
    
    func setUpSideBarViewConstraints(){
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        topLabel.topAnchor.constraint(equalTo: self.sideBarView.topAnchor, constant: 0).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 187).isActive = true
        
        sideBarTableView.translatesAutoresizingMaskIntoConstraints = false
        sideBarTableView.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        sideBarTableView.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        sideBarTableView.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor, constant: 0).isActive = true
        sideBarTableView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 0).isActive = true
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.sideBarView.bottomAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    //MARK: CloseSideBarView
    
    @objc func closeSideBarView(){
        print("tapGesture")
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            for alpha in (0...5).reversed(){
                self.tempView.alpha = CGFloat(alpha/10)
            }
        }, completion: nil)
        isEnableSideBarView = false
    }
    
    //MARK: Swiped To Left
    
    @objc func swipedToLeft(){
        self.view.addGestureRecognizer(swipeToRight)
        self.view.removeGestureRecognizer(swipeToLeft)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            for alpha in (0...5).reversed(){
                self.tempView.alpha = CGFloat(alpha/10)
            }
            
        }, completion: nil)
        isEnableSideBarView = false
    }
    
    //MARK: Swiped To Right
    
    @objc func swipedToRight(){
        self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2
        self.view.addGestureRecognizer(swipeToLeft)
        self.view.removeGestureRecognizer(swipeToRight)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.sideBarView.frame = CGRect(x: 0, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
            
            //            for alpha in (0...5){
            //                self.tempview.alpha = CGFloat(alpha/10)
            //            }
            
            self.tempView.alpha = 0.5
        }, completion: nil)
        isEnableSideBarView = true
    }
    
    //MARK: SideMenu Bar Button Action
    
    @objc func MenuBarButtonAction(){
        print("MenuBar Click!")
        self.imageView.layer.cornerRadius = self.imageView.frame.size.height/2
        
        if isEnableSideBarView{
            self.view.addGestureRecognizer(swipeToRight)
            self.view.removeGestureRecognizer(swipeToLeft)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
                
                //                for alpha in (0...5).reversed(){
                //                    self.tempview.alpha = CGFloat(alpha/10)
                //                }
                
            }, completion: nil)
            
            isEnableSideBarView = false
            
        }else{
            self.view.addGestureRecognizer(swipeToLeft)
            self.view.removeGestureRecognizer(swipeToRight)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.sideBarView.frame = CGRect(x: 0, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
                
                //                for alpha in (0...5){
                //                    self.tempview.alpha = CGFloat(alpha/10)
                //                }
                
                self.tempView.alpha = 0.5
            }, completion: nil)
            
            isEnableSideBarView = true
        }
    }
    
    //MARK: Right BarButton
    
    func rightBarButtonEdit(){
        navigationItem.title = "Product".uppercased()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(cgColor:  CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))]
        //MARK: Cart Button
        cartBarButton.setImage(UIImage(systemName: "cart"), for: .normal)
        cartBarButton.tintColor = UIColor(cgColor:  CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        cartBarButton.backgroundColor = .clear
        cartBarButton.layer.cornerRadius = 5
        cartBarButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        cartBarButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        cartBarButton.transform = CGAffineTransformMakeScale(1.2, 1.2)
        cartBarButton.addTarget(self, action: #selector(allCartActionButton), for: UIControl.Event.touchUpInside)
        let barButton1 = UIBarButtonItem(customView: cartBarButton)
        
        //MARK: ProfileButton
        
        if let profilUrl = Utility.getUserImage(){
            profileBarButton.sd_setImage(with: URL(string: profilUrl), for: UIControl.State.normal)
        }
        profileBarButton.translatesAutoresizingMaskIntoConstraints = false
        profileBarButton.layer.masksToBounds = true
        profileBarButton.backgroundColor = .clear
        profileBarButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileBarButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        profileBarButton.layer.cornerRadius = 20
        profileBarButton.layer.borderWidth = 1
        profileBarButton.layer.borderColor = CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1)
        profileBarButton.addTarget(self, action: #selector(imageProfileActionButton), for: UIControl.Event.touchUpInside)
        let barButton2 = UIBarButtonItem(customView: profileBarButton)
        //MARK: Multiple BarButton space
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = -20
        self.navigationItem.setRightBarButtonItems([barButton2,space,space,barButton1], animated: true)
        
    }
    
    @objc func allCartActionButton() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartAddViewController") as! CartAddViewController
        vc.delegate = self
        vc.selectedItems = addToCart
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func imageProfileActionButton(){
        print("Click!")
    }
    
    func setUpTableView(){
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "productTableViewCell")
    }
    
    //MARK: fetchData
    
    func fetchData(){
        let service = WebService()
        service.call(with: "https://fakestoreapi.com/products", httpMethod: "GET", httpBody: nil) { data in
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                if let data = data {
                    do {
                        self.allProducts = try JSONDecoder().decode([ProductModel].self, from: data)
                        self.productTableView.reloadData()
                    }
                    catch _ {
                        //show error alert
                    }
                }
            }
        }
    }
}

extension ProductListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == productTableView {
            return allProducts.count
        }else{
            return sideMenuData.count
        }
    }
    
    // MARK: UILabel Round
    
    func badgeLabel() -> UILabel {
        badgeCount.translatesAutoresizingMaskIntoConstraints = false
        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
        badgeCount.textAlignment = .center
        badgeCount.layer.masksToBounds = true
        badgeCount.textColor = .white
        badgeCount.font = badgeCount.font.withSize(12)
        badgeCount.backgroundColor = .systemRed
        badgeCount.text = String(cartCount)
        return badgeCount
    }
    
    func showBadge() {
        let badge = badgeLabel()
        cartBarButton.addSubview(badge)
        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: cartBarButton.leftAnchor, constant: 27),
            badge.topAnchor.constraint(equalTo: cartBarButton.topAnchor, constant: -2),
            badge.widthAnchor.constraint(equalToConstant: 20),
            badge.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == productTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "productTableViewCell") as! ProductTableViewCell
            cell.configure(product: allProducts[indexPath.row])
            cell.addToCart.addTarget(self, action: #selector(selectedItem), for: .touchUpInside)
            AppData.addProduct = addToCart.description
            return cell
        }
        else{
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath)as! SideMenuTableViewCell
            cell1.sideMenuImageView.image = self.sideMenuData[indexPath.row].icon
            cell1.sideMenuLabel.text = self.sideMenuData[indexPath.row].title
            return cell1
        }
    }
    
    //MARK: selectCartItem
    
    @objc func selectedItem(_ sender: UIButton){
        if let productCell = sender.superview?.superview as? ProductTableViewCell {
            guard let indexPath = productTableView.indexPath(for: productCell) else { return}
            let item = allProducts[indexPath.row]
            let message = "Are your sure add to cart"
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self](action:UIAlertAction!) in
                addToCart.append(item)
                self.cartBarButton.pulsate()
                cartCount += 1
                AppData.addCart = cartCount
                
                self.badgeCount.text! = String(cartCount)
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}

extension ProductListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == productTableView {
            let storyboradName = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboradName.instantiateViewController(withIdentifier: "ProductsDetailsViewController") as! ProductsDetailsViewController
            vc.pImage = allProducts[indexPath.row].image!
            vc.pTitle = allProducts[indexPath.row].title!
            vc.pDescription = allProducts[indexPath.row].welcomeDescription ?? ""
            vc.pCategory = (allProducts[indexPath.row].category!.rawValue)
            vc.pPrice = "$" + String((allProducts[indexPath.row].price!))
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let cell = tableView.cellForRow(at: indexPath)as! SideMenuTableViewCell
            switch indexPath.row {
                
            case 0:
                let productVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
                self.navigationController?.pushViewController(productVC, animated: true)
                cell.sideMenuImageView.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
                cell.sideMenuLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
                cell.contentView.backgroundColor = UIColor.white
                
            case 1:
                let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                self.navigationController?.pushViewController(profileVC, animated: true)
                cell.sideMenuImageView.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
                cell.sideMenuLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
                cell.contentView.backgroundColor = UIColor.white
                
            case 2:
                let cartsVC = self.storyboard?.instantiateViewController(withIdentifier: "CartAddViewController") as! CartAddViewController
                self.navigationController?.pushViewController(cartsVC, animated: true)
                cell.sideMenuImageView.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
                cell.sideMenuLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
                cell.contentView.backgroundColor = UIColor.white
                
            default:
                let paymentVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
                self.navigationController?.pushViewController(paymentVC, animated: true)
                cell.sideMenuImageView.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
                cell.sideMenuLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
                cell.contentView.backgroundColor = UIColor.white
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == sideBarTableView {
            let cell = tableView.cellForRow(at: indexPath)as! SideMenuTableViewCell
            cell.sideMenuImageView.tintColor = .white
            cell.sideMenuLabel.textColor = .white
            cell.contentView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == productTableView {
            return 194
        }else{
            return 60
        }
    }
    
    //MARK: 3D CAnimation
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let anim = CATransform3DTranslate(CATransform3DIdentity, -100, 10, 0)
        cell.layer.transform = anim
        cell.alpha = 0.3
        UIView.animate(withDuration: 0.7){
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1
        }
    }
}

//MARK: CAnimation cartButton
extension UIView {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.30
        pulse.fromValue = 1
        pulse.toValue = 1.20
        // pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 1
        pulse.damping = 10
        layer.add(pulse, forKey: "pulse")
    }
}

//MARK: cartCount delete pora kome jabe
extension ProductListViewController: CurrentCatNumber {
    func getNumber(_ num: Int) {
        //cartCount = num
        AppData.addCart = num
        self.badgeCount.text = String(AppData.addCart)
    }
}













//    func fetchData(){
//
//        let url = URL(string: "https://fakestoreapi.com/products")
//
//        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: {
//            (data,response,error) in
//
//            guard let data = data, error == nil else{
//                return
//            }
//
//            if let string = String(bytes: data, encoding: .utf8) {
//                print(string)
//            } else {
//                print("not a valid UTF-8 sequence")
//            }
//
//            do{
//                self.allProducts = try JSONDecoder().decode([ProductModel].self,from:data)
//            }catch{
//                print("Error")
//            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        })
//        dataTask.resume()
//    }

