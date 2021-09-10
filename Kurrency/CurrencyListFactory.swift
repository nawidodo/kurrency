//
//  CurrencyListFactory.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 10/09/21.
//

import Foundation

class CurrencyListFactory {
    static func build(viewModel: ListViewModelType) -> CurrencyListViewController {
        let vc = CurrencyListViewController(viewModel: viewModel)
        return vc
    }
}
