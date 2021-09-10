//
//  MainViewController.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 08/09/21.
//

import UIKit

class MainViewController: UITableViewController {
    
    var viewModel: MainViewModelType
    
    required init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: TableHeaderView.id, bundle: nil), forHeaderFooterViewReuseIdentifier: TableHeaderView.id)
        tableView.register(UINib(nibName: CurrencyTableViewCell.id, bundle: nil), forCellReuseIdentifier: CurrencyTableViewCell.id)
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
        tableView.alwaysBounceHorizontal = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = .secondaryBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCurrencies()
        registerCell()
        viewModel.didChooseCurrency = { [unowned self] _ in
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.id, for: indexPath) as! CurrencyTableViewCell
        cell.viewModel = viewModel
        // Configure the cell..
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableHeaderView.id) as! TableHeaderView
        view.tintColor = .primaryBlue
        view.didTapAddButton = { [unowned self] in
            self.viewModel.openCurrencyList { _ in
                
            }
        }
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}
