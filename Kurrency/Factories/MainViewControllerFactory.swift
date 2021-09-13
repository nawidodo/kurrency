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
        let cache = UserDefaults.standard.getObject(forKey: MainViewModel.id, castTo: ViewModelCache.self)
        let viewModel = MainViewModel(service: service, router: router, cache: cache)
        let vc = MainViewController(viewModel: viewModel)
        router.presenter = vc
        return vc
    }
}
