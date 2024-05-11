//
//  AboutTableViewCell.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/11/24.
//

import UIKit

final class AboutTableViewCell: UITableViewCell {
    func configure(with text: String) {
        var content = defaultContentConfiguration()
        content.text = text
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        contentConfiguration = content
        backgroundColor = .clear
    }
}
