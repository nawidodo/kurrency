//
//  ViewModelCache.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation

struct ViewModelCache: Codable {
    var currencies: Set<Currency>
    var shownCurrencies: [Currency]
    var amount: Double
    var factor: Double
    var selectedID: String
}
