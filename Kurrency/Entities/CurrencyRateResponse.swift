//
//  CurrencyRateResponse.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation

// MARK: - CurrencyRateResponse

typealias Rates = [String: Double]

struct CurrencyRateResponse: Codable {
    let timestamp: TimeInterval
    let base: String
    let rates: Rates
}
