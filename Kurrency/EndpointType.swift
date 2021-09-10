//
//  EndpointType.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 05/09/21.
//

import Foundation

protocol EndpointType {
    var url: URL {get}
    var path: String {get}
    var queries: [String: String] {get}
    var body: [String: Any] {get}
    var headers: [String: String] {get}
    var method: HTTPMethod {get}
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
