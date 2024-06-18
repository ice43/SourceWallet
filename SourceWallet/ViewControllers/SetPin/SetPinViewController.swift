//
//  SetPinViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/17/24.
//

import UIKit

final class SetPinViewController: UIViewController {
    // MARK: IB Outlets
    @IBOutlet private weak var numberPad: UIStackView!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private var numbers: [UIButton]!
    
    // MARK: Private properties
    private let pinField = CHIOTPFieldThree()
    private let numberOfDigits = 6
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPinField()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        checkButtonAvailability()
    }
    
    // MARK: IB Actions
    @IBAction private func numberPadButtonPressed(_ sender: UIButton) {
        if let digit = sender.titleLabel?.text {
            pinField.text?.append(digit)
        }
    }
    
    @IBAction private func deleteButtonPressed(_ sender: UIButton) {
        pinField.redraw()
        pinField.text = ""
    }
    
    @IBAction private func clearButtonPressed(_ sender: UIButton) {
        if let currentText = pinField.text, !currentText.isEmpty {
            let updatedText = String(currentText.dropLast())
            pinField.redraw()
            pinField.text = updatedText
        }
    }
    
    // MARK: Private methods
    private func checkButtonAvailability() {
        if pinField.text?.count == numberOfDigits {
            continueButton.isEnabled = true
            continueButton.alpha = 1
            
            numbers.forEach { button in
                button.isUserInteractionEnabled = false
                button.alpha = 0.5
            }
        } else {
            continueButton.isEnabled = false
            continueButton.alpha = 0.5
            
            numbers.forEach { button in
                button.isUserInteractionEnabled = true
                button.alpha = 1
            }
        }
    }
}

// MARK: - UI
private extension SetPinViewController {
    func setupPinField() {
        pinField.translatesAutoresizingMaskIntoConstraints = false
        pinField.numberOfDigits = numberOfDigits
        pinField.boxBackgroundColor = .clear
        pinField.spacing = 20
        pinField.inputView = UIView()
        
        view.addSubview(pinField)
        
        pinField.becomeFirstResponder()
        
        NSLayoutConstraint.activate(
            [
                pinField.bottomAnchor.constraint(equalTo: numberPad.topAnchor, constant: -60),
                pinField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                pinField.widthAnchor.constraint(equalToConstant: 200),
                pinField.heightAnchor.constraint(equalToConstant: 30)
            ]
        )
    }
}
