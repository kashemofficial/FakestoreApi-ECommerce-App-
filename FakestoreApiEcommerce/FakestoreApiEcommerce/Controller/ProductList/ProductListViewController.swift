//
//  ProductListViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 2/12/22.
//

import UIKit

var addToCart = [ProductModel]()

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allProducts = [ProductModel]()
    var cartCount = 0
    let badgeCount = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    let cartBarButton = UIButton(type: .custom)
    let profileBarButton = UIButton(type: .custom)
    let menuBarButton = UIButton(type: .custom)
    var isSlideInMenuPresented = false
    lazy var slideInMenuPadding: CGFloat = self.view.frame.width * 0.30
    
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpTableView()
        fetchData()
        showBadge()
        rightBarButtonEdit()
        leftBarButtonEdit()
        self.badgeCount.text = String(AppData.addCart)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

    //MARK: Left BarButton
    
    func leftBarButtonEdit(){
        menuBarButton.backgroundColor = .clear
        menuBarButton.setImage(UIImage(systemName: "text.justify"), for: .normal)
        menuBarButton.translatesAutoresizingMaskIntoConstraints = false
        menuBarButton.layer.masksToBounds = true
        menuBarButton.backgroundColor = .clear
        menuBarButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        menuBarButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        menuBarButton.transform = CGAffineTransformMakeScale(1.6, 1.6)
        menuBarButton.tintColor = .systemGreen
        menuBarButton.addTarget(self, action: #selector(MenuBarButtonAction), for: UIControl.Event.touchUpInside)
        menuView.pinMenuTo(view, with: slideInMenuPadding)
        containerView.edgeTo(view)
        let leftBarButton1 = UIBarButtonItem(customView: menuBarButton)
        
        self.navigationItem.setLeftBarButtonItems([leftBarButton1], animated: false)
    }
    
    @objc func MenuBarButtonAction(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.containerView.frame.origin.x = self.isSlideInMenuPresented ? 0 : self.containerView.frame.width - self.slideInMenuPadding
        } completion: { (finished) in
            print("Animation finished: \(finished)")
            self.isSlideInMenuPresented.toggle()
        }
    }
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    //MARK: Right BarButton
    
    func rightBarButtonEdit(){
        navigationItem.title = "Product".uppercased()
        //MARK: Cart Button
        cartBarButton.setImage(UIImage(systemName: "cart"), for: .normal)
        cartBarButton.tintColor = .systemGreen
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
        profileBarButton.layer.borderColor = UIColor.lightGray.cgColor
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
        tableView.register(nib, forCellReuseIdentifier: "productTableViewCell")
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
                        self.tableView.reloadData()
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
        return allProducts.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTableViewCell") as! ProductTableViewCell
        cell.configure(product: allProducts[indexPath.row])
        cell.addToCart.addTarget(self, action: #selector(selectedItem), for: .touchUpInside)
        AppData.addProduct = addToCart.description
        return cell
    }
    
    //MARK: selectCartItem
    
    @objc func selectedItem(_ sender: UIButton){
        if let productCell = sender.superview?.superview as? ProductTableViewCell {
            guard let indexPath = tableView.indexPath(for: productCell) else { return}
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
        let storyboradName = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboradName.instantiateViewController(withIdentifier: "ProductsDetailsViewController") as! ProductsDetailsViewController
        vc.pImage = allProducts[indexPath.row].image!
        vc.pTitle = allProducts[indexPath.row].title!
        vc.pDescription = allProducts[indexPath.row].welcomeDescription ?? ""
        vc.pCategory = (allProducts[indexPath.row].category!.rawValue)
        vc.pPrice = "$" + String((allProducts[indexPath.row].price!))
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

extension ProductListViewController: CurrentCatNumber {
    func getNumber(_ num: Int) {
        //cartCount = num
        AppData.addCart = num
        self.badgeCount.text = String(AppData.addCart)
    }
}

//MARK: SideMenu UIView

public extension UIView {
    func edgeTo(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(_ view: UIView, with constant: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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

