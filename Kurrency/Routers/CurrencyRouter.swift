//
//  CurrencyRouter.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import UIKit


enum ListUseCase {
    case base
    case add
    case edit
}

protocol RouterType {
    var chooseEdit: Completion? {get set}
    var chooseDelete: Completion? {get set}
    func openList(viewModel: ListViewModelType)
    func showOptions(title: String)
}

class CurrencyRouter: RouterType {

    var presenter: UIViewController?
    var chooseEdit: Completion?
    var chooseDelete: Completion?

    func openList(viewModel: ListViewModelType) {
        let vc = CurrencyListFactory.build(viewModel: viewModel)
        presenter?.present(vc, animated: true, completion: nil)
    }
    
    func showOptions(title: String) {
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Edit", style: .default, handler: edit))
        ac.addAction(UIAlertAction(title: "Delete", style: .default, handler: delete))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        presenter?.present(ac, animated: true, completion: nil)
    }
    
    private func edit(action: UIAlertAction) {
        chooseEdit?()
    }
    
    private func delete(action: UIAlertAction) {
        chooseDelete?()
    }

}
