//
//  UserContext.swift
//  TestWorkSiberian
//
//  Created by Наташа on 18.06.2022.
//

import Foundation

final class UserContext {
    static var login: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "login")
        }get{
            return UserDefaults.standard.string(forKey: "login")
        }
    }
    static var password: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
        }get{
            return UserDefaults.standard.string(forKey: "password")
        }
    }
    static var isAuth: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: "isAuth")
        }get{
            return UserDefaults.standard.bool(forKey: "isAuth")
        }
    }
}
