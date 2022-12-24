//
//  Utility.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 3/12/22.
//

import Foundation
import UIKit

class Utility : NSObject{

    static func isUserLoggedIn()->Bool{
       return UserDefaults.standard.bool(forKey: "USER_LOGGED_IN")
    }
    
    static func userLoggedIn(_ loggedIn: Bool){
        UserDefaults.standard.set(loggedIn, forKey: "USER_LOGGED_IN")
        UserDefaults.standard.synchronize()
    }
    
    static func getUserImage()->String? {
       return UserDefaults.standard.string(forKey: "USER_IMAGE")
    }
    
    static func setUserImage(_ url: String) {
        UserDefaults.standard.set(url, forKey: "USER_IMAGE")
        UserDefaults.standard.synchronize()
    }
    
}
