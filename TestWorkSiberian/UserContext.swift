//
//  UserContext.swift
//  TestWorkSiberian
//
//  Created by Наташа on 18.06.2022.
//

import Foundation

final class UserContext {
    private (set) lazy var userContext = UserContext()
    private lazy var keychainService = KeychainService()
    private lazy var queue = DispatchQueue(label: "com.eugeneKodzila.TestWorkSiberian", qos: DispatchQoS.userInitiated, attributes: .concurrent)
    
    private static var userDefaults: UserDefaults {
        get {
            return .standard
        }
    }
    
    var login: String? {
        get {
            return queue.sync {
                return UserContext.userDefaults.string(forKey: "login")
            }
        }
        set {
            queue.async(flags: .barrier) {
                UserContext.userDefaults.setValue(newValue, forKey: "login")
            }
        }
    }
    
    var password: String? {
        get {
            return queue.sync {
                return UserContext.userDefaults.string(forKey: "password")
            }
        }
        set {
            queue.async(flags: .barrier) {
                UserContext.userDefaults.setValue(newValue, forKey: "password")
            }
        }
    }
        
    static var isAuth: Bool? {
        set {
            userDefaults.set(newValue, forKey: "isAuth")
        }
        get {
            return userDefaults.bool(forKey: "isAuth")
        }
    }
}
