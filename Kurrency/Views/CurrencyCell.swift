//
//  CurrencyCell.swift
//  Kurrency
//
//  Created by Nugroho Arief Widodo on 28/03/23.
//

import UIKit

class CurrencyCell: UICollectionViewCell {
    
    static var id = "CurrencyCell"

    @IBOutlet weak var amountLabel: PaddingLabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        amountLabel.padding(6, 6, 12, 12)
    }

}
