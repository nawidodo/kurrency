//
//  CurrencyListResponse.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation

// MARK: - CurrencyListResponse
struct CurrencyListResponse: Codable {
    let success: Bool
    let terms, privacy: String
    let currencies: [String: String]
    
    func convert() -> Set<Currency> {
        var curr = Set<Currency>()
        for (key, value) in self.currencies.sorted(by: <) {
            let cu = Currency()
            cu.symbol = key
            cu.name = value
            curr.insert(cu)
        }
        
        return curr
    }
}
