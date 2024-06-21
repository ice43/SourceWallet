//
//  LoginViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/7/24.
//

import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private var textFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateTextFields()
        setupAvailabilityContinueButton()
    }
    
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        var isContinueButtonEnabled = true
        
        for textField in textFields {
            if textField.text?.isEmpty ?? true {
                isContinueButtonEnabled = false
            }
        }
        
        continueButton.isEnabled = isContinueButtonEnabled
        continueButton.alpha = isContinueButtonEnabled ? 1 : 0.5
    }
}

// MARK: - UI
private extension LoginViewController {
    // Setting the availability of the continue button
    func setupAvailabilityContinueButton() {
        for textField in textFields {
            textField.addTarget(
                self,
                action: #selector(textFieldDidChanged),
                for: .editingChanged
            )
        }
    }
    
    func populateTextFields() {
        let flattenedSeedPhrase = DataStore.shared.seedPhrase.flatMap { $0 }
        
        for (index, phrase) in flattenedSeedPhrase.enumerated() {
            if index < textFields.count {
                let textField = textFields[index]
                textField.text = phrase
            }
        }
    }
}
