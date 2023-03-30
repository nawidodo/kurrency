//
//  MainViewModelTests.swift
//  KurrencyTests
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import XCTest
import Combine
@testable import Kurrency

class MainViewModelTests: XCTestCase {
    
    let mockService = CurrencyServiceMock()
    let mockRouter = CurrencyRouterMock()
    var mainViewModel: (MainViewModelType & ListViewModelType)!
    
    var subscribers: Set<AnyCancellable> = []
    
    lazy var currencies: Set<Currency> = {
        let idr = Currency()
        idr.symbol = "IDR"
        let jpy = Currency()
        idr.symbol = "JPY"
        let usd = Currency()
        usd.symbol = "USD"
        return [idr, jpy, usd]
    }()
    
    lazy var quotes: Rates = {
        var q = Rates()
        q["IDR"] = 14000
        return q
    }()



    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // Given
        let viewModel = MainViewModel(service: mockService, router: mockRouter)
        mainViewModel = viewModel
    }
    
    func testFetchCurrencies() {
        // Given
        let receivedAllValues = expectation(description: "all values received")
        mockService.currenciesResult = .success(currencies)
        mockService
            .fetchCurrencies()
            .sink { _ in
            } receiveValue: { currencies in
                // Then
                XCTAssertEqual(currencies.count, 3)
                receivedAllValues.fulfill()
            }
            .store(in: &subscribers)
        // When
        mainViewModel.fetchCurrencies()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchCurrenciesError() {
        // Given
        let receivedAllValues = expectation(description: "all values received")
        mockService.currenciesResult = .failure(ServiceError.invalidResponse)
        mockService
            .fetchCurrencies()
            .sink { _ in
                // Then
                receivedAllValues.fulfill()
            } receiveValue: { currencies in
                XCTFail("Should not return valid result")
            }
            .store(in: &subscribers)
        // When
        mainViewModel.fetchCurrencies()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testFetchQuotes() {
        // Given
        let result = expectation(description: "all values received")
        mockService.quotesResult = .success(quotes)
        mainViewModel.selectedID = "IDR"
        mainViewModel.didGetQuotes = {
            // Then
            result.fulfill()
        }
        // When
        mainViewModel.getQuotes()
        waitForExpectations(timeout: 1, handler: nil)
    }

    
    func testFetchQuotesError() {
        // Given
        let result = expectation(description: "all values received")
        mockService.quotesResult = .failure(ServiceError.invalidResponse)
        mockService
            .fetchQuotes(currencies: [], base: "USD")
            .sink {  _ in
                // Then
                result.fulfill()
            } receiveValue: { _ in
                XCTFail("Should not return valid result")
            }
            .store(in: &subscribers)

        // When
        mainViewModel.getQuotes()
        waitForExpectations(timeout: 1, handler: nil)
    }

        
    func testFetchQuotesFromBase() {
        // When
        let result = expectation(description: "all values received")
        mockService.quotesResult = .success(quotes)
        mainViewModel.openCurrencyList(mode: .base)
        mainViewModel.baseDidChange = { _ in
            // Then
            result.fulfill()
        }
        // When
        mainViewModel.getQuotes()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testOpenCurrencyList() {
        mainViewModel.openCurrencyList(mode: .add)
        XCTAssertEqual(mockRouter.listOpened, 1)
    }
    
    func testShowOptionsFor() {
        // When
        mainViewModel.showOptionsFor(index: 0, currency: Currency())
        
        // Then
        XCTAssertEqual(mockRouter.optionOpened, 1)
    }
    
    func testUpdateAmount() {
        // When
        mainViewModel.updateAmount(260690)
        
        // Then
        XCTAssertEqual(mainViewModel.amount, 260690)
        XCTAssertEqual(mainViewModel.multiplier, 260690)

    }
    
    func testSearchCurrency() {
        
        // Given
        testFetchCurrencies()
        XCTAssertFalse(mainViewModel.currencies.isEmpty)
        
        let term = "JPY"
        let result = expectation(description: "all values received")
        
        // When
        mainViewModel.searchBar(text: term) {
            result.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
        let indexPath = IndexPath(item: 0, section: 0)
        let curr = mainViewModel.getCurrency(indexPath: indexPath)
        
        // Then
        XCTAssertEqual(mainViewModel.sections.count, 1)
        XCTAssertEqual(curr.symbol, term)
        
    }
    
    func testChooseCurrency() {
        // Given
        testFetchCurrencies()
        XCTAssertFalse(mainViewModel.currencies.isEmpty)
        let result = expectation(description: "Update visible currencies")
        mainViewModel.didChooseCurrency = {
            result.fulfill()
        }
        
        // When
        let curr1 = currencies.popFirst()!
        mainViewModel.didChoose(currency: curr1)
        waitForExpectations(timeout: 1, handler: nil)
        // Then
        XCTAssertEqual(mainViewModel.shownCurrencies.count, 1)
    }
    
    func testBaseChange() {
        // Given
        let base = currencies.popFirst()!
        mockService.quotesResult = .success(quotes)
        // When
        mainViewModel.baseDidChange(currency: base)
        // Then
        XCTAssertEqual(mainViewModel.selectedID, base.symbol)
    }
    
    func testChooseDelete() {
        // Given
        let result = expectation(description: "all values received")
        result.expectedFulfillmentCount = 2
        mainViewModel.didChooseCurrency = {
            // Then
            result.fulfill()
        }
        let curr = currencies.first!
        mainViewModel.didChoose(currency: curr)
        mainViewModel.showOptionsFor(index: 0, currency: curr)
        // When
        mockRouter.chooseDelete?()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
