//
//  CurrencyRateResponse.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 10/09/21.
//

import Foundation

// MARK: - CurrencyRateResponse

typealias Quote = [String: Double]

struct CurrencyRateResponse: Codable {
    let success: Bool
    let terms, privacy: String
    let timestamp: TimeInterval
    let source: String
    let quotes: Quote
    
    func rates() -> Quote {
        var temp = Quote()
        for (key, value) in quotes {
            if key.hasPrefix(source) {
                let newKey = String(key.suffix(3))
                temp[newKey] = value
            }
        }
        return temp
    }
}
