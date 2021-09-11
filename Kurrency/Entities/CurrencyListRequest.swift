//
//  CurrencyListRequest.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 06/09/21.
//

import Foundation


struct CurrencyListRequest: EndpointType {
    var url: URL
    
    var path: String
    
    var queries: [String : String] = [:]
    
    var body: [String : Any] = [:]
    
    var headers: [String : String]  = [:]
    
    var method: HTTPMethod = .get
}
