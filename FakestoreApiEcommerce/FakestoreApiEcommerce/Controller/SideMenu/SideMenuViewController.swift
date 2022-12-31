//
//  SideMenuViewController.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 28/12/22.
//

import UIKit

//
//protocol SideMenuViewControllerDelegate {
//    func selectedCell(_ row: Int)
//}

//class SideMenuViewController: UIViewController {
    
//    @IBOutlet weak var headerProfileImage: UIImageView!
//    @IBOutlet weak var headerProfileName: UILabel!
//    @IBOutlet weak var sideMenuTableview: UITableView!
//    @IBOutlet weak var footerNameLabel: UILabel!
    
    
//    
//    var sideBarView: UIView!
//    var sideBarTableView = UITableView()
//    var topLabel = UILabel()
//    var bottomView = UIView()
//    var logOutButton = UIButton()
//    var nameLabel = UILabel()
//    var imageV = UIImageView()
//    var topHeight_navigationBar_statusBar:CGFloat = 0.0
//    var isEnableSideBarView:Bool = false
//
//    var arrData = ["Carts", "Payment", "Products"]
//    var arrImages:[String] = ["carts","payment","product"]
//
//    var swipeToRight = UISwipeGestureRecognizer()
//    var swipetoLeft = UISwipeGestureRecognizer()
//    var tempview = UIView()
//    var tapGesture = UITapGestureRecognizer()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        loadSideBarViewFunctionality()
//        loadGesturefunctionality()
//
//    }
//
//    //MARK: load SideBar View Functionality
//
//    func loadSideBarViewFunctionality(){
//        topHeight_navigationBar_statusBar = UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.frame.height)!
//
//        tempview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
//        tempview.backgroundColor = .lightGray
//        tempview.alpha = 0
//
//        sideBarView = UIView(frame: CGRect(x: -self.view.bounds.width/1.5, y: topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - topHeight_navigationBar_statusBar))
//
//        sideBarTableView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//        sideBarTableView.delegate = self
//        sideBarTableView.dataSource = self
//        sideBarTableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideBarCell")
//        sideBarTableView.separatorStyle = .none
//        sideBarTableView.bounces = false
//
//        topLabel.text = "Slide Out Menu"
//        topLabel.textAlignment = .center
//        topLabel.font = UIFont(name: "Party LET", size: 45)
//        topLabel.textColor = UIColor.white
//        topLabel.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//
//        bottomView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//
//        logOutButton.setTitle("Log Out", for: .normal)
//        logOutButton.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//        logOutButton.titleLabel?.textColor = UIColor.white
//        logOutButton.titleLabel?.font = UIFont(name: "Chalkboard SE", size: 20)
//
//        nameLabel.numberOfLines = 0
//        nameLabel.text = "MD Abul kashem"
//        nameLabel.textColor = UIColor.white
//        nameLabel.textAlignment = NSTextAlignment.center
//        nameLabel.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//
//        imageV.image = UIImage(imageLiteralResourceName: "img1")
//        self.imageV.clipsToBounds = true
//        self.imageV.layer.borderWidth = 1
//        self.imageV.layer.borderColor = UIColor.white.cgColor
//
//        self.view.addSubview(tempview)
//        self.view.addSubview(sideBarView)
//        self.sideBarView.addSubview(topLabel)
//        self.sideBarView.addSubview(bottomView)
//        self.sideBarView.addSubview(sideBarTableView)
//
//        self.bottomView.addSubview(logOutButton)
//        self.bottomView.addSubview(nameLabel)
//        self.bottomView.addSubview(imageV)
//
//        setUpSideBarViewConstraints()
//        setUpBottomViewConstraints()
//    }
//
//    // MARK: loadGesturefunctionality
//
//    func loadGesturefunctionality(){
//        swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipedToRight))
//        swipeToRight.direction = .right
//        self.view.addGestureRecognizer(swipeToRight)
//
//        swipetoLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipedToLeft))
//        swipetoLeft.direction = .left
//
//        tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSideBarView))
//        tempview.addGestureRecognizer(tapGesture)
//    }
//
//    func setUpBottomViewConstraints(){
//        logOutButton.translatesAutoresizingMaskIntoConstraints = false
//        logOutButton.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20).isActive = true
//        //        logOutBtn.trailingAnchor.constraint(equalTo: self.imageview.leadingAnchor, constant: -20).isActive = true
//        logOutButton.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 15).isActive = true
//        logOutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//
//        nameLabel.translatesAutoresizingMaskIntoConstraints = false
//        nameLabel.leadingAnchor.constraint(equalTo: self.bottomView.leadingAnchor, constant: 20).isActive = true
//        //        nameLbl.trailingAnchor.constraint(equalTo: self.imageview.leadingAnchor, constant: -20).isActive = true
//        nameLabel.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -15).isActive = true
//        nameLabel.topAnchor.constraint(equalTo: self.logOutButton.bottomAnchor, constant: 0).isActive = true
//
//        imageV.translatesAutoresizingMaskIntoConstraints = false
//        imageV.topAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 20).isActive = true
//        imageV.trailingAnchor.constraint(equalTo: self.bottomView.trailingAnchor, constant: -20).isActive = true
//        imageV.bottomAnchor.constraint(equalTo: self.bottomView.bottomAnchor, constant: -20).isActive = true
//        imageV.widthAnchor.constraint(equalToConstant: 50).isActive = true
//    }
//
//    //MARK: setUp SideBar ViewConstraints
//
//    func setUpSideBarViewConstraints(){
//        topLabel.translatesAutoresizingMaskIntoConstraints = false
//        topLabel.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
//        topLabel.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
//        topLabel.topAnchor.constraint(equalTo: self.sideBarView.topAnchor, constant: 0).isActive = true
//        topLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
//
//        sideBarTableView.translatesAutoresizingMaskIntoConstraints = false
//        sideBarTableView.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
//        sideBarTableView.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
//        sideBarTableView.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor, constant: 0).isActive = true
//        sideBarTableView.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor, constant: 0).isActive = true
//
//        bottomView.translatesAutoresizingMaskIntoConstraints = false
//        bottomView.leadingAnchor.constraint(equalTo: self.sideBarView.leadingAnchor, constant: 0).isActive = true
//        bottomView.trailingAnchor.constraint(equalTo: self.sideBarView.trailingAnchor, constant: 0).isActive = true
//        bottomView.bottomAnchor.constraint(equalTo: self.sideBarView.bottomAnchor, constant: 0).isActive = true
//        bottomView.heightAnchor.constraint(equalToConstant: 90).isActive = true
//    }
//
//    //MARK: CloseSideBarView
//
//    @objc func closeSideBarView(){
//        print("tapGesture")
//        self.view.addGestureRecognizer(swipeToRight)
//        self.view.removeGestureRecognizer(swipetoLeft)
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//            self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
//
//            for alpha in (0...5).reversed(){
//                self.tempview.alpha = CGFloat(alpha/10)
//            }
//        }, completion: nil)
//        isEnableSideBarView = false
//    }
//
//    //MARK: Swiped To Left
//
//    @objc func swipedToLeft(){
//        self.view.addGestureRecognizer(swipeToRight)
//        self.view.removeGestureRecognizer(swipetoLeft)
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//            self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
//
//            for alpha in (0...5).reversed(){
//                self.tempview.alpha = CGFloat(alpha/10)
//            }
//
//        }, completion: nil)
//        isEnableSideBarView = false
//    }
//
//    //MARK: Swiped To Right
//
//    @objc func swipedToRight(){
//        self.imageV.layer.cornerRadius = self.imageV.frame.size.height/2
//        self.view.addGestureRecognizer(swipetoLeft)
//        self.view.removeGestureRecognizer(swipeToRight)
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//            self.sideBarView.frame = CGRect(x: 0, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
//
//            for alpha in (0...5){
//                self.tempview.alpha = CGFloat(alpha/10)
//            }
//            self.tempview.alpha = 0.5
//        }, completion: nil)
//        isEnableSideBarView = true
//    }
//
//    //MARK: SideMenu Bar Button Action
//
//    @objc func MenuBarButtonAction(){
//        print("MenuBar Click!")
//        self.imageV.layer.cornerRadius = self.imageV.frame.size.height/2
//
//        if isEnableSideBarView{
//            self.view.addGestureRecognizer(swipeToRight)
//            self.view.removeGestureRecognizer(swipetoLeft)
//
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//                self.sideBarView.frame = CGRect(x: -self.view.bounds.width/1.5, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
//
//                for alpha in (0...5).reversed(){
//                    self.tempview.alpha = CGFloat(alpha/10)
//                }
//
//            }, completion: nil)
//
//            isEnableSideBarView = false
//
//        }else{
//            self.view.addGestureRecognizer(swipetoLeft)
//            self.view.removeGestureRecognizer(swipeToRight)
//
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
//                self.sideBarView.frame = CGRect(x: 0, y: self.topHeight_navigationBar_statusBar, width: self.view.bounds.width/1.5, height: self.view.bounds.height - self.topHeight_navigationBar_statusBar)
//
//                for alpha in (0...5){
//                    self.tempview.alpha = CGFloat(alpha/10)
//                }
//                self.tempview.alpha = 0.5
//            }, completion: nil)
//
//            isEnableSideBarView = true
//        }
//    }
//
//}

//extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell1 = tableView.dequeueReusableCell(withIdentifier: "sideBarCell", for: indexPath)as! SideMenuTableViewCell
//        cell1.sideMenuImageView.image = UIImage(named: arrImages[indexPath.row])
//        cell1.sideMenuLabel.text = self.arrData[indexPath.row]
//        return cell1
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)as! SideMenuTableViewCell
//        switch indexPath.row {
//        case 0:
//            let storyborad = UIStoryboard(name: "Main", bundle: nil)
//            let cartVC = storyborad.instantiateViewController(identifier: "ProductListViewController")as! ProductListViewController
//            self.navigationController?.pushViewController(cartVC, animated: true)
//            cell.sideMenuImageView.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//            cell.sideMenuLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//            cell.contentView.backgroundColor = UIColor.white
//
//        case 1:
//            let paymentVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewController") as! PaymentViewController
//            self.navigationController?.pushViewController(paymentVC, animated: true)
//            cell.sideMenuImageView.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//            cell.sideMenuLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//            cell.contentView.backgroundColor = UIColor.white
//
//        default:
//            let productVC = self.storyboard?.instantiateViewController(withIdentifier: "ProductsDetailsViewController") as! ProductsDetailsViewController
//            self.navigationController?.pushViewController(productVC, animated: true)
//            cell.sideMenuImageView.tintColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//            cell.sideMenuLabel.textColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//            cell.contentView.backgroundColor = UIColor.white
//
//        }
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)as! SideMenuTableViewCell
//        cell.sideMenuImageView.tintColor = UIColor.white
//        cell.sideMenuLabel.textColor = UIColor.white
//        cell.contentView.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 239/255, green: 109/255, blue: 73/255, alpha: 1))
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
//
//}


