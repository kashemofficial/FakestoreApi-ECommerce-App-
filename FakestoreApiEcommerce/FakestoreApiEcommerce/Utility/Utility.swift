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
    
    //getUserImage
    
    static func getUserImage()->String? {
       return UserDefaults.standard.string(forKey: "USER_IMAGE")
    }
    
    static func setUserImage(_ url: String) {
        UserDefaults.standard.set(url, forKey: "USER_IMAGE")
        UserDefaults.standard.synchronize()
    }
    
    //getUserName
    
    static func getUserName()-> String? {
        return UserDefaults.standard.string(forKey: "USER_NAME")
    }
    
    static func setUserName(_ url: String){
        UserDefaults.standard.set(url, forKey: "USER_NAME")
        UserDefaults.standard.synchronize()
    }
    
    
    static func isUserLogoutIn()-> Bool{
        return UserDefaults.standard.bool(forKey: "USER_LOGOUT")
    }
    
    static func userLogout(_ logout: Bool){
        UserDefaults.standard.set(logout, forKey: "USER_LOGOUT")
        UserDefaults.standard.synchronize()
    }
    
    
}
