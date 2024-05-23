//
//  DenominationView.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/14/24.
//

import UIKit

protocol DenominationViewDelegate: AnyObject {
    func cancelButtonTapped()
    func okButtonTapped()
}

final class DenominationView: UIView {
    weak var delegate: DenominationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        setupView()
        setupButtonStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupView()
        setupButtonStackView()
    }
    
    private func commonInit() {
        let nib = UINib(nibName: "Denomination", bundle: nil)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(view)
        }
    }
    
    private func setupView() {
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.backModal.cgColor
        clipsToBounds = true
    }
    
    private func setupButtonStackView() {
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside
        )
        
        let okButton = UIButton(type: .system)
        okButton.setTitle("Ok", for: .normal)
        okButton.addTarget(
            self,
            action: #selector(okButtonTapped),
            for: .touchUpInside
        )
        
        let stackView = UIStackView(arrangedSubviews: [cancelButton, okButton])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [
                stackView.trailingAnchor.constraint(
                    equalTo: safeAreaLayoutGuide.trailingAnchor,
                    constant: -30
                ),
                stackView.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -22
                )
            ]
        )
    }
    
    @objc private func cancelButtonTapped() {
        delegate?.cancelButtonTapped()
    }
    
    @objc private func okButtonTapped() {
        delegate?.okButtonTapped()
    }
}
