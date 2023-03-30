//
//  String+Extensions.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import UIKit

extension String {
    var double: Double? {
        let formatter = currencyFormatter()
        guard let number = formatter.number(from: self) else {
            return nil
        }
        return Double(truncating: number)
    }
    
    var isValidDecimal: Bool {
        if let regex = try? NSRegularExpression(pattern: "^[0-9]*((\\.|,)[0-9]{0,2})?$", options: .caseInsensitive) {
            return regex.numberOfMatches(in: self, options: .reportProgress, range: NSRange(location: 0, length: (self as NSString).length)) > 0
        }
        return false
    }
    
}

