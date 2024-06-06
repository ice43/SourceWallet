//
//  WatchOnlyViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/4/24.
//

import UIKit

final class WatchOnlyViewController: UIViewController {
    // MARK: IB Outlets
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var firstNotice: UILabel!
    @IBOutlet private weak var secondNotice: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    
    private var isUsernameValid: Bool {
        return usernameTextField.text?.isEmpty == false
                && usernameTextField.text?.count ?? 0 >= 8
    }
    
    private var isPasswordValid: Bool {
        return passwordTextField.text?.isEmpty == false
                && passwordTextField.text?.count ?? 0 >= 8
    }
    
    // MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Watch-only credentials"
        
        initialSetupNotice()
        initialSetupSaveButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        usernameTextField.addTarget(
            self,
            action: #selector(showFirstNotice),
            for: .editingChanged
        )
        
        passwordTextField.addTarget(
            self,
            action: #selector(showSecondNotice),
            for: .editingChanged
        )
    }
    
    // MARK: IB Actions
    @IBAction func saveButtonPressed() {
        let alertController = UIAlertController(
            title: "Not found",
            message: "This way is temporarily not supported",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.usernameTextField.text = ""
            self.passwordTextField.text = ""
            self.initialSetupSaveButton()
            self.initialSetupNotice()
        }
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

// MARK: - UI
private extension WatchOnlyViewController {
    // Initial setting up of notices under text fields
    func initialSetupNotice() {
        firstNotice.isHidden = true
        secondNotice.isHidden = true
    }
    
    // Initial setting up of SaveButton
    func initialSetupSaveButton() {
        saveButton.isEnabled = false
        saveButton.setTitleColor(
            .backModal.withAlphaComponent(0.5),
            for: .disabled
        )
        saveButton.backgroundColor = saveButton.tintColor.withAlphaComponent(0.5)
    }
    
    // Changing the button depending on the presence of text in the text field
    func passwordTextFieldDidChanged() {
        if isUsernameValid && isPasswordValid {
            saveButton.isEnabled = true
            saveButton.setTitleColor(.backModal, for: .normal)
            saveButton.backgroundColor = saveButton.tintColor
        } else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(.backModal.withAlphaComponent(0.5), for: .disabled)
            saveButton.backgroundColor = saveButton.tintColor.withAlphaComponent(0.5)
        }
    }
    
    @objc func showFirstNotice() {
        firstNotice.isHidden = isUsernameValid
    }
    
    @objc func showSecondNotice() {
        secondNotice.isHidden = isPasswordValid
        
        passwordTextFieldDidChanged()
    }
}

