//
//  CurrencyRouterMock.swift
//  KurrencyTests
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import Foundation
@testable import Kurrency

class CurrencyRouterMock: RouterType {
    var chooseEdit: Completion?
    
    var chooseDelete: Completion?
    
    var listOpened = 0
    var optionOpened = 0
    
    func openList(viewModel: ListViewModelType) {
        listOpened += 1
    }
    
    func showOptions(title: String) {
        optionOpened += 1
    }
}
