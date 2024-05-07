//
//  LoginViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/7/24.
//

import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private var labelsAndTextFields: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSegmentedControl()
        initialSetupContinueButton()
    }
    
    @IBAction private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "0"
        
        let textFieldCount = Int(selectedValue) ?? 0
        
        // Hide all current labels and text fields
        for view in self.labelsAndTextFields {
            view.isHidden = true
        }
        
        // Show the required number of labels and text fields
        for index in 0..<textFieldCount {
            self.labelsAndTextFields[index].isHidden = false
        }
    }
}

// MARK: - UI
private extension LoginViewController {
    func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControlValueChanged(segmentedControl)
    }
    
    func initialSetupContinueButton() {
        continueButton.setTitleColor(
            .white.withAlphaComponent(0.5),
            for: .disabled
        )
        continueButton.backgroundColor = continueButton.tintColor.withAlphaComponent(0.5)
    }
}
