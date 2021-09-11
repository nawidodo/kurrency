//
//  CurrencyRateRequest.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 10/09/21.
//

import Foundation

struct CurrencyRateRequest: EndpointType {
    var url: URL
    
    var path: String
    
    var queries: [String : String] = [:]
    
    var body: [String : Any] = [:]
    
    var headers: [String : String] = [:]
    
    var method: HTTPMethod = .get
}
