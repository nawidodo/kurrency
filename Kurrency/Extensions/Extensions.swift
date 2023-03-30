//
//  Extensions.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation


public func currencyFormatter() -> NumberFormatter {
    
    let formatter = NumberFormatter()
    formatter.groupingSeparator = ","
    formatter.decimalSeparator = "."
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.usesGroupingSeparator = true
    formatter.groupingSize = 3
    
    return formatter
}
