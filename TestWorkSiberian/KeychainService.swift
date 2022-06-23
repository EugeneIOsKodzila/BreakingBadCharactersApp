//
//  KeychainService.swift
//  TestWorkSiberian
//
//  Created by Наташа on 22.06.2022.
//

import Foundation

final class KeychainService {
    
    private lazy var currentKeyChain = Keychain(service: SettingsKeyChain.keyChainName.rawValue)
    
    private enum SettingsKeyChain: String {
        case keyChainName
        case password
        case login
        case token
    }
    
    var login: String? {
        get {
            return currentKeyChain[SettingsKeyChain.login.rawValue]
        }
        set(newLogin) {
            currentKeyChain[SettingsKeyChain.login.rawValue] = newLogin
        }
    }
    
    var password: String? {
        get {
            return currentKeyChain[SettingsKeyChain.password.rawValue]
        }
        set(newPassword) {
            currentKeyChain[SettingsKeyChain.password.rawValue] = newPassword
        }
    }
    
    var token:String? {
        get {
            return currentKeyChain[SettingsKeyChain.token.rawValue]
        }
        set(newToken) {
            currentKeyChain[SettingsKeyChain.token.rawValue] = newToken
        }
    }
}
