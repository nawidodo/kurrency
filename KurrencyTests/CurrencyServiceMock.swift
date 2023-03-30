//
//  CurrencyServiceMock.swift
//  KurrencyTests
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Combine
@testable import Kurrency

class CurrencyServiceMock: CurrencyServiceType {
                
    var currenciesResult: Result<Set<Currency>, Error>!
    var quotesResult: Result<Rates, Error>!
    
    func fetchCurrencies() -> AnyPublisher<Set<Currency>, Error> {
        return currenciesResult
            .publisher
            .eraseToAnyPublisher()
    }
    
    func fetchQuotes(currencies: [Currency], base: String) -> AnyPublisher<Rates, Error> {
        return quotesResult
            .publisher
            .eraseToAnyPublisher()
    }

}
