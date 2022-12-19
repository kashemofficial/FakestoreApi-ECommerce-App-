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
    let rightBarButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
    //let imageProfile = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUpTableView()
        fetchData()
        showBadge()
        //showBadgeImage()
        rightBarButtonEdit()
        imageProfileSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.badgeCount.text = String(AppData.addCart)
    }
    
    func imageProfileSetup(){
        let image = UIImage(named: "img")!
        let imageSize = CGSizeMake(60, 42)
        let marginX: CGFloat = (self.navigationController!.navigationBar.frame.size.width / 3) - (imageSize.width / 3)
        let imageView = UIImageView(frame: CGRect(x: marginX, y: 0, width: imageSize.width, height: imageSize.height))
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
    }
    
    func rightBarButtonEdit(){
        title = "Product"
        //button.frame = CGRectMake(0,0, 100, 60)
        rightBarButton.setImage(UIImage(systemName: "cart"), for: .normal)
        //        button.contentVerticalAlignment = .fill
        //        button.contentHorizontalAlignment = .fill
        //        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        rightBarButton.tintColor = .white
        rightBarButton.backgroundColor = .systemBlue
        rightBarButton.layer.cornerRadius = 5
        rightBarButton.addTarget(self, action: #selector(allCartActionButton), for: UIControl.Event.touchUpInside)
        let barButton = UIBarButtonItem()
        barButton.customView = rightBarButton
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func allCartActionButton() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartAddViewController") as! CartAddViewController
        vc.delegate = self
        vc.selectedItems = addToCart
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUpTableView(){
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "productTableViewCell")
    }
    
    //MARK: fetchData
    
    func fetchData(){
        let url = URL(string: "https://fakestoreapi.com/products")
        
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: {
            (data,response,error) in
            
            guard let data = data, error == nil else{
                return
            }
            do{
                self.allProducts = try JSONDecoder().decode([ProductModel].self,from:data)
            }catch{
                print("Error")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        dataTask.resume()
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
        rightBarButton.addSubview(badge)
        NSLayoutConstraint.activate([
            badge.leftAnchor.constraint(equalTo: rightBarButton.leftAnchor, constant: 20),
            badge.topAnchor.constraint(equalTo: rightBarButton.topAnchor, constant: -5),
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
                
                self.rightBarButton.pulsate()
                if sender.tag == 0{
                    cartCount += 1
                    AppData.addCart = cartCount
                    
                }
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




