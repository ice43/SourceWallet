//
//  StorageFunds.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/5/24.
//

import UIKit

final class StorageFunds: UIView {
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let securityLabel = UILabel()
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupPositions()
    }
}

// MARK: - UI
private extension StorageFunds {
    func setupViews() {
        // Setting up an title label
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        
        // Setting up an description label
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .lightGray
        addSubview(descriptionLabel)
        
        // Setting up an security label
        securityLabel.font = .boldSystemFont(ofSize: 14)
        securityLabel.backgroundColor = .backList
        securityLabel.layer.cornerRadius = 20
        securityLabel.layer.masksToBounds = true
        securityLabel.textAlignment = .center
        addSubview(securityLabel)
        
        // Setting up the button
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let imageButton = UIImage(systemName: "arrow.right")?.withConfiguration(configuration)
        button.setImage(imageButton, for: .normal)
        button.imageView?.tintColor = .backModal
        button.backgroundColor = .tintColor
        button.layer.cornerRadius = 10
        addSubview(button)
    }
    
    func setupPositions() {
        // Setting up position of title label
        titleLabel.frame = CGRect(
            x: 20,
            y: 20,
            width: frame.width - 40,
            height: 30
        )
        
        // Setting up position of description label
        descriptionLabel.frame = CGRect(
            x: 20,
            y: titleLabel.frame.maxY + 10,
            width: frame.width - 40,
            height: 50
        )
        
        // Setting up position of security label
        let labelSize = securityLabel.intrinsicContentSize
        securityLabel.frame = CGRect(
            x: 20,
            y: descriptionLabel.frame.maxY + 10,
            width: labelSize.width + 20,
            height: labelSize.height + 20
        )
        
        // Setting up position of button
        button.frame = CGRect(
            x: frame.width - 55,
            y: securityLabel.frame.maxY + 10,
            width: 40,
            height: 40
        )
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    StorageFunds()
}
