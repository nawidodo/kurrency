//
//  CurrencyService.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation
import Combine

class CurrencyService: NSObject, CurrencyServiceType {
            
    private let config = ConfigManager.shared.config
    private let builder = RequestBuilder()
    private var latestUpdate: TimeInterval = Date().timeIntervalSince1970
        
    func fetchCurrencies() -> AnyPublisher<Set<Currency>, Error> {
        var currencyList = CurrencyListRequest(url: config.baseURL, path: config.listPath)
        currencyList.queries["app_id"] = config.app_id
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
    
    func fetchQuotes(currencies: [Currency], base: String) -> AnyPublisher<Rates, Error> {
        let quotes = currencies.map { $0.symbol }.joined(separator: ",")
        var req = CurrencyRateRequest(url: config.baseURL, path: config.ratePath)
        req.queries["app_id"] = config.app_id
        req.queries["symbols"] = quotes
        req.queries["base"] = base
        guard var request = builder.build(endpoint: req) else {
            return Fail(error: ServiceError.request).eraseToAnyPublisher()
        }
        
        //Invalidate cache after 30*60 = 30 minutes
        if Date().timeIntervalSince1970 - latestUpdate >= 30*60 {
            request.cachePolicy = .reloadIgnoringCacheData
        }
    
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: CurrencyRateResponse.self, decoder: JSONDecoder())
            .map { [unowned self] response in
                latestUpdate = Date().timeIntervalSince1970
                return response.rates
            }
            .eraseToAnyPublisher()
    }
}

protocol CurrencyServiceType {
    func fetchCurrencies() -> AnyPublisher<Set<Currency>, Error>
    func fetchQuotes(currencies: [Currency], base: String) -> AnyPublisher<Rates, Error>
}
