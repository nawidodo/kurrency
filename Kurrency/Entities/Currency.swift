//
//  Currency.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 10/09/21.
//

import Foundation

class Currency: NSObject, Codable {
    @objc var symbol: String =  ""
    @objc var name: String = ""
    var value: Double = 0 // Relative to USD
        
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
