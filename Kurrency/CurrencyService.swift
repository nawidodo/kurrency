//
//  CurrencyService.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 06/09/21.
//

import Foundation
import Combine

class CurrencyService: NSObject, CurrencyServiceType {
    
    private let config = ConfigManager.shared.config
    private let builder = RequestBuilder()
        
    func fetchCurrencies() -> AnyPublisher<Set<Currency>, Error> {
        var currencyList = CurrencyListRequest(url: config.baseURL, path: config.listPath)
        currencyList.queries["access_key"] = config.accessKey
        guard let request = builder.build(endpoint: currencyList) else {
            return Fail(error: ServiceError.request).eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: CurrencyListResponse.self, decoder: JSONDecoder())
            .map { $0.convert() }
            .eraseToAnyPublisher()
    }
    
}

protocol CurrencyServiceType {
    func fetchCurrencies() -> AnyPublisher<Set<Currency>, Error>
}
