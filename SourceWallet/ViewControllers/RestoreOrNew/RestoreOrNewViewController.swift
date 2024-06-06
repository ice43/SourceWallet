//
//  RestoreOrNewViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/6/24.
//

import UIKit

final class RestoreOrNewViewController: UIViewController {
    @IBOutlet private weak var restoreWalletButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setRestoreWalletButton()
    }
}

// MARK: - UI
private extension RestoreOrNewViewController {
    func setRestoreWalletButton() {
        restoreWalletButton.layer.borderWidth = 2
        restoreWalletButton.layer.borderColor = UIColor.white.cgColor
    }
}
