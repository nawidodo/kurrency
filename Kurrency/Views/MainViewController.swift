//
//  MainViewController.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 08/09/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction private func didTapAddButton(_ sender: Any) {
        viewModel.openCurrencyList(mode: .add)
    }
    
    var viewModel: MainViewModelType
    
    required init(viewModel: MainViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: "MainViewController", bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        initSetup()
        setupViewModel()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func registerCell() {
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.register(UINib(nibName: CurrencyCell.id, bundle: nil), forCellWithReuseIdentifier: CurrencyCell.id)
    }
    
    private func initSetup(){
        
        idLabel.text = viewModel.selectedID
        amountLabel.text = viewModel.amount.formatted
        
        amountLabel.addTapGestureRecognizer { [unowned self] in
            amountTextField.becomeFirstResponder()
        }
        
        view.addTapGestureRecognizer { [unowned self] in
            amountTextField.endEditing(true)
        }
    }
    
    private func setupViewModel(){
        viewModel.fetchCurrencies()
        viewModel.didChooseCurrency = { [unowned self] in
            viewModel.getQuotes()
        }
        
        viewModel.didGetQuotes = { [unowned self]  in
            collectionView.reloadData()
        }
        
        viewModel.amountDidChange = { [unowned self] in
            amountLabel.text = viewModel.amount.formatted
            collectionView.reloadData()
        }
        
        viewModel.baseDidChange = { [unowned self] id in
            idLabel.text = id
            collectionView.reloadData()
        }
                        
        idLabel.addTapGestureRecognizer { [unowned self] in
            viewModel.openCurrencyList(mode: .base)
        }
    }
    
    private func calculateCellSize() -> CGSize {
        let width = (UIScreen.main.bounds.width-16*3)/2
        let heigth = width/163*120
        return CGSize(width: width, height: heigth)
    }
    
}

extension MainViewController: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.shownCurrencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCell.id, for: indexPath) as! CurrencyCell
        let currency = viewModel.shownCurrencies[indexPath.row]
        cell.idLabel.text = currency.symbol
        cell.nameLabel.text = currency.name
        cell.amountLabel.text = (currency.value * viewModel.multiplier).formatted
        cell.addTapGestureRecognizer { [unowned self] in
            viewModel.showOptionsFor(index: indexPath.row, currency: currency)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateCellSize()
    }
}

extension MainViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let newText = text.replacingCharacters(in: range, with: string)
        if newText.isValidDecimal, let amount = newText.double {
            viewModel.updateAmount(amount)
        } else if newText == "." {
            viewModel.updateAmount(0)
        }
        return newText.isValidDecimal
    }
}


