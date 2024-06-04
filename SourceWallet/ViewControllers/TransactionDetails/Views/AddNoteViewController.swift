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
        
        initialSetupSubmitButton()
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
    
    func setSheet() {
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
    func initialSetupSubmitButton() {
        submitButton.setTitleColor(
            .backModal.withAlphaComponent(0.5),
            for: .disabled
        )
        submitButton.backgroundColor = submitButton.tintColor.withAlphaComponent(0.5)
    }
    
    // MARK: Changing the button depending on the presence of text in the text field
    @objc private func noteTextFieldDidChanged(_ textField: UITextField) {
        if textField.text == "" {
            submitButton.isEnabled = false
            submitButton.setTitleColor(.backModal.withAlphaComponent(0.5), for: .disabled)
            submitButton.backgroundColor = submitButton.tintColor.withAlphaComponent(0.5)
        } else {
            submitButton.isEnabled = true
            submitButton.setTitleColor(.backModal, for: .normal)
            submitButton.backgroundColor = submitButton.tintColor
        }
    }
}
