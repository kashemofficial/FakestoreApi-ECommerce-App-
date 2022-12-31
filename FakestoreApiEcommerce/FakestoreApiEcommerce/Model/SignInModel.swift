//
//  SignInModel.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 10/12/22.
//

import Foundation

struct LoginResponse: Codable {
    let username: String?
    let image: String?
    let token: String?
    let maidenName: String?
    let birthDate: String?
    let phone: String?
    
}
