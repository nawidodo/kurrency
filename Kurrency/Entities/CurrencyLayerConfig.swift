//
//  CurrencyLayerConfig.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation

struct CurrencyLayerConfig: Codable {
    var app_id: String
    var baseURL: URL
    var listPath: String
    var ratePath: String
}
