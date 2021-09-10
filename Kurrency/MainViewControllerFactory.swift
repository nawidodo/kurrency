//
//  MainViewControllerFactory.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 10/09/21.
//

import Foundation


class MainViewControllerFactory {
    public static func build() -> MainViewController {
        let service = CurrencyService()
        let router = CurrencyRouter()
        let viewModel = MainViewModel(service: service, router: router)
        let vc = MainViewController(viewModel: viewModel)
        router.presenter = vc
        return vc
    }
}
