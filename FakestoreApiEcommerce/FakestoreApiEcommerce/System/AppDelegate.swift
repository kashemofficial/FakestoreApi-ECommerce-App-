//
//  AppDelegate.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 30/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let loginVC = sb.instantiateViewController(identifier: "ViewController")
        let navVC = UINavigationController(rootViewController: loginVC)
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
        
    }
    
}

