//
//  TableHeaderView.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 08/09/21.
//

import UIKit

class TableHeaderView: UITableViewHeaderFooterView {
    
    static let id = "TableHeaderView"
    
    var didTapAddButton: Completion?
    
    @IBAction private func didTapAddButton(_ sender: Any) {
        didTapAddButton?()
    }
}
