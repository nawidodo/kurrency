//
//  Double+Extensions.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation

extension Double {
    
    var formatted: String {
        let value = NSNumber(value: self)
        return currencyFormatter().string(from: value)!
    }
}

