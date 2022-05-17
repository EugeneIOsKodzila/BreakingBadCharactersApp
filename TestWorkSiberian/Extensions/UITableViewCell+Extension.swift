//
//  UITableViewCell+Extension.swift
//  TestWorkSiberian
//
//  Created by Наташа on 06.05.2022.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    static var identifier: String {
        return String(describing: self)
    }
}
