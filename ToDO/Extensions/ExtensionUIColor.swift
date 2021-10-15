//
//  ExtensionUIColor.swift
//  ToDO
//
//  Created by Дмитрий Юдин on 15.10.2021.
//

import UIKit

extension UIColor {
    static var floatingButtonColor: UIColor {
        guard let color = UIColor(named: "FloatingButtonColor") else { return .secondarySystemBackground }
        return color
    }
    
    static var shadowColor: UIColor {
        guard let color = UIColor(named: "ShadowColor") else { return .black }
        return color
    }
}
