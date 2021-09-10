//
//  CurrencyRouter.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 10/09/21.
//

import UIKit

class CurrencyRouter: RouterType {
    
    var presenter: UIViewController?
    
    func openList(viewModel: ListViewModelType) {
        let vc = CurrencyListFactory.build(viewModel: viewModel)
        presenter?.present(vc, animated: true, completion: nil)
    }
}
