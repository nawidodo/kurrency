//
//  CurrencyServiceMock.swift
//  KurrencyTests
//
//  Created by Nugroho Arief Widodo on 12/09/21.
//

import Combine
@testable import Kurrency

class CurrencyServiceMock: CurrencyServiceType {
                
    var currenciesResult: Result<Set<Currency>, Error>!
    var quotesResult: Result<Quote, Error>!
    
    func fetchCurrencies() -> AnyPublisher<Set<Currency>, Error> {
        return currenciesResult
            .publisher
            .eraseToAnyPublisher()
    }
    
    func fetchQuotes(currencies: [Currency], source: String) -> AnyPublisher<Quote, Error> {
        return quotesResult
            .publisher
            .eraseToAnyPublisher()
    }

}
