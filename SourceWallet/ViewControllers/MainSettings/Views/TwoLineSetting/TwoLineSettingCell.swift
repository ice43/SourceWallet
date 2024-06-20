//
//  TwoLineSettingCell.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/11/24.
//

import UIKit

final class TwoLineSettingCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var chevronImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.layer.cornerRadius = 10
        // This is necessary to create margins between cells
        contentView.frame = contentView.frame.inset(
            by: UIEdgeInsets(
                top: 10,
                left: 20,
                bottom: 10,
                right: 20
            )
        )
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectedBackgroundView?.layer.cornerRadius = 10
        selectedBackgroundView?.layer.masksToBounds = true
    }
}
