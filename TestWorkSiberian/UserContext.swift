//
//  UserContext.swift
//  TestWorkSiberian
//
//  Created by Наташа on 18.06.2022.
//

import Foundation

final class UserContext {
    private static var userDefaults: UserDefaults {
        get {
            return .standard
        }
    }
    
    static var login: String? {
        set {
            userDefaults.set(newValue, forKey: "login")
        }
        get {
            return userDefaults.string(forKey: "login")
        }
    }
    
    static var password: String? {
        set {
            userDefaults.set(newValue, forKey: "password")
        }
        get {
            return userDefaults.string(forKey: "password")
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
