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
    
    @IBAction func saveButtonPressed() {
        let alertController = UIAlertController(
            title: "Not found",
            message: "This way is temporarily not supported",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
