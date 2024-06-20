//
//  Policy.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/20/24.
//

import UIKit

final class Policy: UIView {
    let stackView = UIStackView()
    let typeLabel = UILabel()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
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
private extension Policy {
    func setupViews() {
        // Setting up the stack view
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        addSubview(stackView)
        
        // Setting up an type label
        typeLabel.font = .boldSystemFont(ofSize: 12)
        typeLabel.text = "SINGLESIG"
        typeLabel.textColor = .lightGray
        typeLabel.backgroundColor = .backList
        typeLabel.layer.cornerRadius = 20
        typeLabel.layer.masksToBounds = true
        typeLabel.textAlignment = .center
        addSubview(typeLabel)
        
        // Setting up an title label
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.text = "Standard"
        titleLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)
        
        // Setting up an description label
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.text = "Cheaper singlesig option"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .lightGray
        stackView.addArrangedSubview(descriptionLabel)
        
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
        // Setting up position of security label
        let labelSize = typeLabel.intrinsicContentSize
        typeLabel.frame = CGRect(
            x: 20,
            y: 20,
            width: labelSize.width + 20,
            height: labelSize.height + 20
        )
        
        // Setting up the position of the stack view
        stackView.frame = CGRect(
            x: 20,
            y: typeLabel.frame.maxY + 10,
            width: frame.width - 40,
            height: 90
        )
        
        // Setting up position of button
        button.frame = CGRect(
            x: frame.width - 55,
            y: typeLabel.frame.minY,
            width: 40,
            height: 40
        )
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    Policy()
}
