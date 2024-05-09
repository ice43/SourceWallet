//
//  BottomMenuView.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/7/24.
//

import UIKit

final class BottomMenuView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Creating a background
        backgroundColor = .backModal
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Creating a Send button
        let sendButton = ButtonBottomView(
            frame: .zero,
            title: "Send",
            image: "send",
            imagePadding: -10,
            contentInsets: NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 15
            )
        )
        
        // Creating a QR button
        let qrButton = UIButton()
        let qrImage = UIImage(systemName: "qrcode")
        qrButton.backgroundColor = .accent
        qrButton.setImage(qrImage, for: .normal)
        qrButton.imageView?.tintColor = .white
        qrButton.layer.cornerRadius = 10
        qrButton.layer.masksToBounds = true
        
        // Creating a Receive button
        let receiveButton = ButtonBottomView(
            frame: .zero,
            title: "Receive",
            image: "receive",
            imagePadding: -25,
            contentInsets: NSDirectionalEdgeInsets(
                top: 0,
                leading: 0,
                bottom: 0,
                trailing: 35
            )
        )
        
        // Creating a horizontal stackview
        let stackView = UIStackView(
            arrangedSubviews: [
                sendButton,
                qrButton,
                receiveButton
            ]
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        addSubview(stackView)
        
        // Setting up constraints
        NSLayoutConstraint.activate(
            [
                qrButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                qrButton.widthAnchor.constraint(equalToConstant: 50),
                qrButton.heightAnchor.constraint(equalToConstant: 50)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                sendButton.leadingAnchor.constraint(equalTo: leadingAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                receiveButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                receiveButton.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }
}


// MARK: - Preview
@available(iOS 17.0, *)
#Preview {
    BottomMenuView()
}