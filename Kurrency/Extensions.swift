//
//  Extensions.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 08/09/21.
//

import UIKit


extension Double {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = 2
        let value = NSNumber(value: self)
        return formatter.string(from: value)!
    }
}

extension Bundle {
    func resolve<T: Codable>(type: T.Type, name: String, ext: String) -> T? {
        let decoder = PropertyListDecoder()
        
        do {
            guard let bundle = self.path(forResource: name, ofType: ext), let data = FileManager.default.contents(atPath: bundle) else {
                return nil
            }
            let config = try decoder.decode(type, from: data)
            return config
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}

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

extension NSObject {
    var className: String {
        return NSStringFromClass(type(of: self))
    }
}

protocol DesignableBorder {

    var cornerRadius: CGFloat { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor? { get set }

}

@IBDesignable extension UIView: DesignableBorder {

    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = self.layer.borderColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { self.layer.borderColor = newValue?.cgColor }
    }

}

protocol DesignableShadow {

    var shadowColor: UIColor? { get set }
    var shadowOffset: CGSize { get set }
    var shadowRadius: CGFloat { get set }
    var shadowOpacity: Float { get set }

}

@IBDesignable extension UIView: DesignableShadow {

    @IBInspectable var shadowColor: UIColor? {
        get {
            guard let cgColor = self.layer.shadowColor else { return nil }
            return UIColor(cgColor: cgColor)
        }
        set { self.layer.shadowColor = newValue?.cgColor }
    }

    @IBInspectable var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set { self.layer.shadowOffset = newValue }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get { return self.layer.shadowRadius }
        set { self.layer.shadowRadius = newValue }
    }

    @IBInspectable var shadowOpacity: Float {
        get { return self.layer.shadowOpacity }
        set { self.layer.shadowOpacity = newValue }
    }

}
