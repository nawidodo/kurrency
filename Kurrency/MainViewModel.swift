//
//  MainViewModel.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 08/09/21.
//

import Foundation
import Combine

enum MainSections {
    case header
    case content
}

typealias CurrencyCompletion = (Currency) -> Void
typealias Completion = () -> Void

protocol MainViewModelType {
    var shownCurrencies: [Currency] {get}
    var didChooseCurrency: CurrencyCompletion? {get set}
    func fetchCurrencies()
    func openCurrencyList(completion: CurrencyCompletion)
}

protocol ListViewModelType {
    var sections: [ListSection] {get}
    func didChoose(currency: Currency)
    func getCurrency(indexPath: IndexPath) -> Currency
}

protocol RouterType {
    func openList(viewModel: ListViewModelType)
}

class MainViewModel: NSObject, MainViewModelType {
    
        
    private var service: CurrencyServiceType
    private var subscribers: Set<AnyCancellable> = []
    private(set) var currencies: Set<Currency> = []
    private(set) var shownCurrencies: [Currency] = []
    private(set) var router: RouterType
    var didChooseCurrency: CurrencyCompletion?

    init(service: CurrencyServiceType, router: RouterType) {
        self.service = service
        self.router = router
    }
    
    func fetchCurrencies() {
        service
            .fetchCurrencies()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { currencies in
                self.currencies = currencies
            })
            .store(in: &subscribers)
    }
    
    func openCurrencyList(completion: (Currency) -> Void) {
        router.openList(viewModel: self)
    }
}

extension MainViewModel: ListViewModelType {
    var sections: [ListSection] {
        let temp = Dictionary(grouping: self.currencies.subtracting(self.shownCurrencies), by: { String($0.id.prefix(1)) } )
        let keys = temp.keys.sorted()
        let sections = keys.map { ListSection(letter: $0, currencies: temp[$0]!) }
        return sections
    }
    
    func didChoose(currency: Currency) {
        shownCurrencies.append(currency)
        didChooseCurrency?(currency)
    }
    
    func getCurrency(indexPath: IndexPath) -> Currency {
        return sections[indexPath.section].currencies[indexPath.row]
    }

}
