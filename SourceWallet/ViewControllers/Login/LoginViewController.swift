//
//  LoginViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/7/24.
//

import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private var labelsAndTextFields: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetupContinueButton()
    }
    
   
}

// MARK: - UI
private extension LoginViewController {
    func initialSetupContinueButton() {
        continueButton.setTitleColor(
            .white.withAlphaComponent(0.5),
            for: .disabled
        )
        continueButton.backgroundColor = continueButton.tintColor.withAlphaComponent(0.5)
    }
}
