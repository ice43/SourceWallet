//
//  TransactionViewCell.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/7/24.
//

import UIKit

final class TransactionViewCell: UITableViewCell {
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    
    private var currentBalance: String?
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 10
        // This is necessary to create margins between cells
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(
                top: 5,
                left: 0,
                bottom: 5,
                right: 0
            )
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectedBackgroundView?.layer.cornerRadius = 10
        selectedBackgroundView?.layer.masksToBounds = true
    }
    
    func configureCell(withData data: Transaction) {
        typeLabel.text = data.type
        amountLabel.text = data.amount
        amountLabel.textColor = data.type == "Received" ? .accent : .white
        dateLabel.text = data.date
        typeImage.image = UIImage(named: data.type.lowercased())
        
        // This is necessary to restore the amount after hiding
        currentBalance = data.amount
    }
    
    func hideAmountLabel() {
        amountLabel.text = "*****"
        amountLabel.textColor = .white
    }
    
    func showAmountLabel() {
        amountLabel.text = currentBalance
        amountLabel.textColor = typeLabel.text == "Received" ? .accent : .white
    }
}
