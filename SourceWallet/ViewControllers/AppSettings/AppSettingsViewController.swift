//
//  AppSettingsViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/6/24.
//

import UIKit

final class AppSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func moreInfoButtonPressed() {
        guard let url = URL(string: "https://www.hackingwithswift.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func buttonsTapped() {
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
