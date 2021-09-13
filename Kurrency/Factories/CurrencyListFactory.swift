//
//  CurrencyListFactory.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 10/09/21.
//

import UIKit

class CurrencyListFactory {
    static func build(viewModel: ListViewModelType) -> UIViewController {
        let vc = CurrencyListViewController(viewModel: viewModel)
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
}
