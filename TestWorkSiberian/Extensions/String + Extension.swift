//
//  String + Extension.swift
//  TestWorkSiberian
//
//  Created by Наташа on 28.04.2022.
//

import Foundation

extension String {    
    var isValidEmail: Bool {
        let emailRegEx = "[a-zA-Z0-9._]{1,30}+@[a-zA-Z0-9]{1,10}+\\.[a-zA-Z]{1,10}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
