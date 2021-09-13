//
//  CurrencyListViewController.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 10/09/21.
//

import UIKit

struct ListSection {
    var letter: String
    var currencies: [Currency]
}

class CurrencyListViewController: UITableViewController {

    var viewModel: ListViewModelType
    var cellID = "cellID"
    
    var searchController: UISearchController!

    
    required init(viewModel: ListViewModelType) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(CurrencyIndexCell.self, forCellReuseIdentifier: cellID)
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.delegate = self // Monitor when the search button is tapped.
        searchController.obscuresBackgroundDuringPresentation = false
        // Place the search bar in the navigation bar.
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.sections[section].currencies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let currency = viewModel.getCurrency(indexPath: indexPath)
        cell.textLabel?.text = currency.symbol
        cell.detailTextLabel?.text = currency.name
        // Configure the cell...

        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return viewModel.sections.map { $0.letter }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].letter
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = viewModel.getCurrency(indexPath: indexPath)
        switch viewModel.currentMode {
        case .base:
            viewModel.baseDidChange(currency: currency)
        default:
            viewModel.didChoose(currency: currency)
        }
        searchController.isActive = false
        tableView.deselectRow(at: indexPath, animated: true)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CurrencyListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text!
        viewModel.searchBar(text: text) { [unowned self] in
            tableView.reloadData()
        }
    }
    
}

extension CurrencyListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}


class CurrencyIndexCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
