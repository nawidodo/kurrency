//
//  Double+Extensions.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 11/09/21.
//

import Foundation

extension Double {
    
    var formatted: String {
        let value = NSNumber(value: self)
        return currencyFormatter().string(from: value)!
    }
}

