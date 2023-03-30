//
//  Currency.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation

class Currency: NSObject, Codable {
    @objc var symbol: String =  "USD"
    @objc var name: String = "United State Dollar"
    var value: Double = 1 // Relative to USD
        
    enum ExpressionKeys: String {
        case symbol
        case name
    }
}

extension Currency: Comparable {
    static func < (lhs: Currency, rhs: Currency) -> Bool {
        lhs.symbol < rhs.symbol
    }
}
