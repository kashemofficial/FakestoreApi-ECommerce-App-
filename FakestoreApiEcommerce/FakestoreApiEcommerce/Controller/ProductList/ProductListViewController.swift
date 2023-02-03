//
//  ProductListViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 2/12/22.
//

import UIKit

//var addToCart = [ProductModel]()

protocol ProductViewPresentor {
    func displayView()
}

class ProductListViewController: UIViewController, ProductView {
    
    @IBOutlet weak var productTableView: UITableView!
    
    var allProducts : [ProductModel]?
    var cartModel = DatabaseHelper()

    var cartCount = 0
    let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let cartBarButton = UIButton()
    let profileBarButton = UIButton(type: .custom)
    let menuBarButton = UIButton(type: .custom)
    let transition = SlideTransitions()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpTableView()
        fetchData()
       // showBadge()
        rightBarButtonEdit()
        
       // self.badgeCount.text = String(AppData.addCart)
        self.navigationItem.setHidesBackButton(true, animated: true)
        //addSlideMenuButton()
        leftBarButtonEdit()
        self.view.backgroundColor = .systemGray6
        cartModel.cartView = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       _ =  cartModel.fetchCart()
    }
    
    //MARK: Left BarButton
    
    func leftBarButtonEdit(){
        menuBarButton.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        menuBarButton.translatesAutoresizingMaskIntoConstraints = false
        menuBarButton.layer.masksToBounds = true
        menuBarButton.backgroundColor = .clear
        menuBarButton.tintColor = UIColor(cgColor:  CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        menuBarButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        menuBarButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        menuBarButton.transform = CGAffineTransformMakeScale(1.7, 1.9)
        menuBarButton.addTarget(self, action: #selector(onSlideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        let leftBarButton1 = UIBarButtonItem(customView: menuBarButton)
        self.navigationItem.setLeftBarButtonItems([leftBarButton1], animated: false)
        
    }

    //MARK: Right BarButton
    
    func rightBarButtonEdit(){
        navigationItem.title = "Product".uppercased()
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(cgColor:  CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))]
        //MARK: Cart Button
        cartBarButton.setImage(UIImage(systemName: "cart"), for: .normal)
        cartBarButton.tintColor = UIColor(cgColor:  CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
        cartBarButton.backgroundColor = .clear
        cartBarButton.setTitleColor(.black, for: .normal)

        cartBarButton.layer.cornerRadius = 5
        cartBarButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
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
//        vc.delegate = self
//        vc.selectedItems = addToCart
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: ImageProfile
    
    @objc func imageProfileActionButton(){
        print("Click!")
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(profileVC, animated: true)
        
    }
    
    func setUpTableView(){
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        productTableView.register(nib, forCellReuseIdentifier: "productTableViewCell")
    }
    
    func saveOnCart(_ index: Int) {
        guard let item = allProducts?[index] else { return }
        cartModel.addToCart(item: item)
    }
    
    func onTapAddCart(index: Int) {
        saveOnCart(index)
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

extension ProductListViewController : UITableViewDataSource ,CartViewModelDelegate,ProductViewPresentor {
    
    func displayCartCount(number: Int) {
       cartBarButton.setTitle("\(number)", for: .normal)
       //badgeCount.setValue(number, forKey: "Key")
    }
    
    func displayView() {
        productTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allProducts?.count ?? 0
    }
    
    // MARK: UILabel Round
    
//    func badgeLabel() -> UILabel {
//        badgeCount.translatesAutoresizingMaskIntoConstraints = false
//        badgeCount.layer.cornerRadius = badgeCount.bounds.size.height / 2
//        badgeCount.textAlignment = .center
//        badgeCount.layer.masksToBounds = true
//        badgeCount.textColor = .white
//        badgeCount.font = badgeCount.font.withSize(12)
//        badgeCount.backgroundColor = .systemRed
//        badgeCount.text = String(cartCount)
//        return badgeCount
//    }
//
//    func showBadge() {
//        let badge = badgeLabel()
//        cartBarButton.addSubview(badge)
//        NSLayoutConstraint.activate([
//            badge.leftAnchor.constraint(equalTo: cartBarButton.leftAnchor, constant: 25),
//            badge.topAnchor.constraint(equalTo: cartBarButton.topAnchor, constant: -1),
//            badge.widthAnchor.constraint(equalToConstant: 20),
//            badge.heightAnchor.constraint(equalToConstant: 20)
//        ])
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTableViewCell") as! ProductTableViewCell
        cell.configure(product: allProducts![indexPath.row])
       // cell.addToCart.addTarget(self, action: #selector(selectedItem), for: .touchUpInside)
        cell.delegate = self
        cell.addToCart?.tag = indexPath.row
        return cell
    }
    
    //MARK: selectCartItem
//
//    @objc func selectedItem(_ sender: UIButton){
//        if let productCell = sender.superview?.superview as? ProductTableViewCell {
//            guard let indexPath = productTableView.indexPath(for: productCell) else { return }
//            let item = allProducts![indexPath.row]
//            let message = "Are your sure add to cart"
//            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { [self](action:UIAlertAction!) in
//                addToCart.append(item)
//                self.cartBarButton.pulsate()
//                cartCount += 1
//                AppData.addCart = cartCount
//                self.badgeCount.text! = String(cartCount)
//            }))
//
//            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//
//        }
//    }
    
    
    
}

extension ProductListViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboradName = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboradName.instantiateViewController(withIdentifier: "ProductsDetailsViewController") as! ProductsDetailsViewController
        vc.pImage = allProducts![indexPath.row].image!
        vc.pTitle = allProducts![indexPath.row].title!
        vc.pDescription = allProducts![indexPath.row].welcomeDescription ?? ""
        vc.pCategory = (allProducts![indexPath.row].category!.rawValue)
        vc.pPrice = "$" + String((allProducts![indexPath.row].price!))
        self.navigationController?.pushViewController(vc, animated: true)
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
//extension ProductListViewController: CurrentCatNumber {
//    func getNumber(_ num: Int) {
//        //cartCount = num
//        AppData.addCart = num
//        self.badgeCount.text = String(AppData.addCart)
//    }
//}


extension ProductListViewController: SlideMenuDelegate{

    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        //        let topViewController : UIViewController = self.navigationController!.topViewController!
        //print("View Controller is : \(topViewController) \n", terminator: "")
        switch(index){
        case 0:
            print("Home\n", terminator: "")
            
            self.openViewControllerBasedOnIdentifier("ProductListViewController")
            break
        case 1:
            print("Play\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("ProfileViewController")
            break
        case 2:
            self.openViewControllerBasedOnIdentifier("CartAddViewController")
            break
        case 3:
            self.openViewControllerBasedOnIdentifier("PaymentViewController")
        default:
            print("default\n", terminator: "")
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        
        let topViewController : UIViewController = self.navigationController!.topViewController!
        
        if (topViewController.restorationIdentifier == destViewController.restorationIdentifier){
            self.navigationController!.pushViewController(destViewController, animated: true)
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(topViewController, animated: true)
        }
    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            
            sender.tag = 0;
            
            let viewMenuBack : UIView = view.subviews.last!
            
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            
            return
        }
        
        sender.isEnabled = false
        sender.tag = 10
        
        let menuVC : SideMenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
    
}

//extension ProductListViewController: UIViewControllerTransitioningDelegate{
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.isPresenting = true
//        return transition
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.isPresenting = false
//        return transition
//    }
//
//}

