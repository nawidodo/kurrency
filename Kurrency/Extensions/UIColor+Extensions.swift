//
//  UIColor+Extensions.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 11/09/21.
//

import UIKit

extension UIColor {
    
    convenience init(rgb: UInt) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
    
    open class var primaryBlue: UIColor {
        return UIColor(rgb: 0x056EE9)
    }
    
    open class var secondaryBlue: UIColor {
        return UIColor(rgb: 0xF0F7FF)
    }
}
