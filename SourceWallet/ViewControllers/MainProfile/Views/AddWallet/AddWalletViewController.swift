//
//  AddWalletViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/20/24.
//

import UIKit

final class AddWalletViewController: UIViewController {
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var walletTextField: UITextField!
    
    var onWalletAdded: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSheet()
        walletTextField.becomeFirstResponder()
        setupDisabledSubmitButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        walletTextField.addTarget(
            self,
            action: #selector(walletTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    @IBAction private func submitButtonPressed() {
        guard let walletName = walletTextField.text, !walletName.isEmpty else {
            return
        }
        
        onWalletAdded?(walletName)
        
        let alertController = UIAlertController(
            title: nil,
            message: "Your wallet has been added successfully",
            preferredStyle: .alert
        )
        alertController.view.backgroundColor = .black.withAlphaComponent(0.7)
        alertController.view.alpha = 0.7
        alertController.view.layer.cornerRadius = 10
        
        present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alertController.dismiss(animated: true, completion: nil)
            self.walletTextField.text = ""
            self.walletTextFieldDidChanged(self.walletTextField)
            self.dismiss(animated: true)
        }
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension AddWalletViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    func setSheet() {
        sheetPresentationController?.prefersGrabberVisible = true
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            280
        }
        sheetPresentationController?.detents = [detent]
    }
}

// MARK: - UI
private extension AddWalletViewController {
    // MARK: Initial setup of SubmitButton
    func setupDisabledSubmitButton() {
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
    }
    
    func setupEnabledSubmitButton() {
        submitButton.isEnabled = true
        submitButton.alpha = 1
    }
    
    // MARK: Changing the button depending on the presence of text in the text field
    @objc private func walletTextFieldDidChanged(_ textField: UITextField) {
        if textField.text == "" {
            setupDisabledSubmitButton()
        } else {
            setupEnabledSubmitButton()
        }
    }
}
