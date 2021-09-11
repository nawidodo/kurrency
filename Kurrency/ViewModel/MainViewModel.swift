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
typealias StringCompletion = (String) -> Void


protocol MainViewModelType {
    var selectedID: String {get set}
    var shownCurrencies: [Currency] {get}
    var didChooseCurrency: Completion? {get set}
    var didGetQuotes: Completion? {get set}
    var baseDidChange: StringCompletion? {get set}
    var amountDidChange: Completion? {get set}
    var amount: Double {get set}
    var multiplier: Double {get}
    func fetchCurrencies()
    func openCurrencyList(mode: ListUseCase)
    func getQuotes()
    func updateAmount(_ amount: Double)
    func showOptionsFor(index: Int, currency: Currency)
}

protocol ListViewModelType {
    var sections: [ListSection] {get}
    var currentMode: ListUseCase {get set}
    func didChoose(currency: Currency)
    func baseDidChange(currency: Currency)
    func getCurrency(indexPath: IndexPath) -> Currency
}

class MainViewModel: NSObject, MainViewModelType {
            
    private var service: CurrencyServiceType
    private var subscribers: Set<AnyCancellable> = []
    private(set) var currencies: Set<Currency> = []
    private(set) var shownCurrencies: [Currency] = []
    private(set) var router: RouterType
    var selectedID: String = "USD"
    var selectedIndex: Int = -1
    var didChooseCurrency: Completion?
    var didGetQuotes: Completion?
    var baseDidChange: StringCompletion?
    var amountDidChange: Completion?
    var amount: Double = 1
    var factor: Double = 1
    var multiplier: Double {
        return amount / factor
    }
    var currentMode: ListUseCase = .add
    
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
    
    private func runLiveUpdate() {
        service
            .fetchQuotes(currencies: shownCurrencies, source: "USD")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [unowned self] quote in
                for currency in shownCurrencies {
                    if let value = quote[currency.id] {
                        currency.value = value
                    }
                    if selectedID == currency.id {
                        factor = currency.value
                    }
                }
                switch currentMode {
                case .base:
                    let _ = shownCurrencies.popLast()
                    baseDidChange?(selectedID)
                default:
                    didGetQuotes?()
                }
            })
            .store(in: &subscribers)
    }
    
    
    func getQuotes() {
        runLiveUpdate()
        Timer.publish(every: 30*60, on: .current, in: .default)
            .autoconnect()
            .sink { [unowned self] _ in
                runLiveUpdate()
            }
            .store(in: &subscribers)
    }
    
    func openCurrencyList(mode: ListUseCase) {
        currentMode = mode
        router.openList(viewModel: self)
    }
    
    func updateAmount(_ amount: Double) {
        self.amount = amount
        amountDidChange?()
    }
    
    func showOptionsFor(index: Int, currency: Currency) {
        selectedIndex = index
        currentMode = .edit
        router.chooseEdit = { [unowned self] in
            router.openList(viewModel: self)
        }
        
        router.chooseDelete = { [unowned self] in
            shownCurrencies.remove(at: index)
            didChooseCurrency?()
        }
        
        router.showOptions(title: currency.id)
    }
}

extension MainViewModel: ListViewModelType {
    
    var sections: [ListSection] {
        let data = currentMode == .base ? currencies : currencies.subtracting(shownCurrencies).filter { $0.id != selectedID }
        let temp = Dictionary(grouping: data, by: { String($0.id.prefix(1)) } )
        let keys = temp.keys.sorted()
        let sections = keys.map { ListSection(letter: $0, currencies: temp[$0]!.sorted(by: <)) }
        return sections
    }
    
    func didChoose(currency: Currency) {
        
        switch currentMode {
        case .edit:
            shownCurrencies[selectedIndex] = currency
        default:
            shownCurrencies.append(currency)
        }
        
        didChooseCurrency?()
    }
    
    func getCurrency(indexPath: IndexPath) -> Currency {
        return sections[indexPath.section].currencies[indexPath.row]
    }
    
    func baseDidChange(currency: Currency) {
        selectedID = currency.id
        shownCurrencies.append(currency)
        getQuotes()
    }

}
