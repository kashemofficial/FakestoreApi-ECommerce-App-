//
//  AppDelegate.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 30/11/22.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        var vc: UIViewController!
        
        if Utility.isUserLoggedIn() {
            vc = sb.instantiateViewController(identifier: "ProductListViewController")
        }
        else {
            vc = sb.instantiateViewController(identifier: "LoginViewController")
        }
        
        let navVC = UINavigationController(rootViewController: vc)
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
        
    }
    
    func logout(){
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "LoginViewController")

        let navVC = UINavigationController(rootViewController: vc)
        window?.rootViewController = navVC
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AddCartList")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}



