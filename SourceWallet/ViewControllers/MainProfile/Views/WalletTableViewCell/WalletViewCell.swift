//
//  WalletTableViewCell.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/10/24.
//

import UIKit

final class WalletViewCell: UITableViewCell {
    @IBOutlet private weak var nameWallet: UILabel!
    @IBOutlet private weak var dotImage: UIImageView!
    
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
    
    func configureCell(withData data: Wallet, isSelected: Bool) {
        nameWallet.text = data.name
        dotImage.isHidden = !isSelected
    }
}
