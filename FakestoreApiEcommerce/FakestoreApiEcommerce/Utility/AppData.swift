//
//  AppData.swift
//  FakestoreApiEcommerce
//
//  Created by Abul Kashem on 16/12/22.
//

import Foundation


@propertyWrapper
struct Storage<T: Codable> {
    private let key: String
    private let defaultValue: T

    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            // Read value from UserDefaults
            guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
                // Return defaultValue when no data in UserDefaults
                return defaultValue
            }

            // Convert data to the desire data type
            let value = try? JSONDecoder().decode(T.self, from: data)
            return value ?? defaultValue
        }
        set {
            // Convert newValue to data
            let data = try? JSONEncoder().encode(newValue)
            
            // Set value to UserDefaults
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}

@propertyWrapper
struct EncryptedStringStorage {

    private let key: String

    init(key: String) {
        self.key = key
    }

    var wrappedValue: String {
        get {
            // Get encrypted string from UserDefaults
            return UserDefaults.standard.string(forKey: key) ?? ""
        }
        set {
            // Encrypt newValue before set to UserDefaults
            let encrypted = encrypt(value: newValue)
            UserDefaults.standard.set(encrypted, forKey: key)
        }
    }

    private func encrypt(value: String) -> String {
        // Encryption logic here
        return String(value.reversed())
    }
}

struct AppData {
    
    /// example
    /*
    @Storage(key: "enable_auto_login_key", defaultValue: false)
    static var enableAutoLogin: Bool
    
    // Declare a User object
    @Storage(key: "user_key", defaultValue: User(firstName: "", lastName: "", lastLogin: nil))
    static var user: User
    
    @EncryptedStringStorage(key: "password_key")
    static var password: String
    */
    
    @Storage(key: "addcat", defaultValue: 0)
    static var addCart: Int

}
