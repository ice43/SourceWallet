//
//  AddNoteViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/3/24.
//

import UIKit

final class AddNoteViewController: UIViewController {
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var noteTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSheet()
        noteTextField.becomeFirstResponder()
        setupDisabledSubmitButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noteTextField.addTarget(
            self,
            action: #selector(noteTextFieldDidChanged),
            for: .editingChanged
        )
    }
    
    @IBAction private func submitButtonPressed() {
        let alertController = UIAlertController(
            title: "Success",
            message: "Your note has been added successfully",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in 
            self.noteTextField.text = ""
            self.noteTextFieldDidChanged(self.noteTextField)
            self.dismiss(animated: true)
        }
    
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension AddNoteViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    private func setSheet() {
        sheetPresentationController?.prefersGrabberVisible = true
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            280
        }
        sheetPresentationController?.detents = [detent]
    }
}

// MARK: - UI
private extension AddNoteViewController {
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
    @objc func noteTextFieldDidChanged(_ textField: UITextField) {
        if textField.text == "" {
            setupDisabledSubmitButton()
        } else {
            setupEnabledSubmitButton()
        }
    }
}
