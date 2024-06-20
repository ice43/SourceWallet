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
            title: nil,
            message: "This way is temporarily not supported",
            preferredStyle: .alert
        )
        alertController.view.backgroundColor = .black.withAlphaComponent(0.7)
        alertController.view.alpha = 0.7
        alertController.view.layer.cornerRadius = 10
        
        present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}
