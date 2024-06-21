//
//  PgpViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/4/24.
//

import UIKit

final class PgpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PGP key"
    }
    
    @IBAction private func saveButtonPressed() {
        Utilities.showAlertControllerUnsupportedAction(for: self)
    }
}
