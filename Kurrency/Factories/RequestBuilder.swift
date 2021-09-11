//
//  RequestBuilder.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 05/09/21.
//

import Foundation


class RequestBuilder {
    
    func build(endpoint: EndpointType) -> URLRequest? {
        var components = URLComponents(url: endpoint.url, resolvingAgainstBaseURL: false)
        components?.path = endpoint.path
        let queries = endpoint.queries.map { URLQueryItem(name: $0, value: $1) }
        components?.queryItems = queries
        
        guard let url = components?.url else {
            return nil
        }
        
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        request.httpMethod = endpoint.method.rawValue
        
        endpoint.headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        
        return request
    }
}
