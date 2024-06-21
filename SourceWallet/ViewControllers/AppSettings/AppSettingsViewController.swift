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
    
    @IBAction private func moreInfoButtonPressed() {
        guard let url = URL(string: "https://www.hackingwithswift.com") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction private func buttonsTapped() {
        Utilities.showAlertControllerUnsupportedAction(for: self)
    }
}
