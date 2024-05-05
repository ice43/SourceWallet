//
//  WhatsCollectedView.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/5/24.
//

import UIKit

final class WhatsCollectedView: UIView {
    let firstTitle = UILabel()
    let secondTitle = UILabel()
    
    let firstDescription = UILabel()
    let secondDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBackgroundColor()
        setupTitles()
        setupDescriptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupTitles() {
        firstTitle.text = "What's collected"
        firstTitle.textAlignment = .left
        firstTitle.font = .systemFont(ofSize: 17)
        firstTitle.frame = CGRect(x: 20, y: 10, width: 200, height: 30)
        addSubview(firstTitle)
        
        secondTitle.text = "What's NOT collected"
        secondTitle.textAlignment = .left
        secondTitle.font = .systemFont(ofSize: 17)
        secondTitle.frame = CGRect(x: 20, y: 130, width: 200, height: 30)
        addSubview(secondTitle)
    }
    
    private func setupDescriptions() {
        firstDescription.text = "Pseudonymous identifier, country, page visits, button presses, general app configuration, OS & App version, loading times"
        firstDescription.textAlignment = .left
        firstDescription.font = .systemFont(ofSize: 15)
        firstDescription.textColor = .lightGray
        firstDescription.numberOfLines = 0
        firstDescription.frame = CGRect(x: 20, y: 40, width: 300, height: 90)
        addSubview(firstDescription)
        
        secondDescription.text = "Recovery phrases, key material, addresses, balances, user contact info, IP address, detailed location"
        secondDescription.textAlignment = .left
        secondDescription.font = .systemFont(ofSize: 15)
        secondDescription.textColor = .lightGray
        secondDescription.numberOfLines = 0
        secondDescription.frame = CGRect(x: 20, y: 150, width: 300, height: 90)
        addSubview(secondDescription)
    }
    
    private func setupBackgroundColor() {
        backgroundColor = .backList
    }
}

// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    WhatsCollectedView()
}
