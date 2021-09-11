//
//  CurrencyLayerConfig.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 06/09/21.
//

import Foundation

struct CurrencyLayerConfig: Codable {
    var accessKey: String
    var baseURL: URL
    var listPath: String
    var ratePath: String
}
