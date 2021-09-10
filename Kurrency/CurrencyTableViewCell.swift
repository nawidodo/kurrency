//
//  CurrencyTableViewCell.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 08/09/21.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: MainViewModelType!
    
    static let id = "CurrencyTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
        
    func registerCell() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.register(UINib(nibName: CurrencyCell.id, bundle: nil), forCellWithReuseIdentifier: CurrencyCell.id)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        collectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width, height: CGFloat(MAXFLOAT))
        collectionView.layoutIfNeeded()
        return collectionView.contentSize
    }
    
    func calculateCellSize() -> CGSize {
        let width = (UIScreen.main.bounds.width-16*3)/2
        let heigth = width/163*120
        return CGSize(width: width, height: heigth)
    }
}

extension CurrencyTableViewCell: UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.shownCurrencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CurrencyCell.id, for: indexPath) as! CurrencyCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CurrencyTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateCellSize()
    }
}
