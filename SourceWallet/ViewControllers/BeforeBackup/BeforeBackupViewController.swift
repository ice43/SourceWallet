//
//  BeforeBackupViewController.swift
//  SourceWallet
//
//  Created by Paul Makey on 9.05.24.
//

import UIKit

final class BeforeBackupViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Before You Backup"
    }
    
    @IBAction func showRecoveryPhraseButtonPressed() {
        let setPhraseViewController = SetPhraseViewController()
        
        navigationController?.pushViewController(setPhraseViewController, animated: true)
    }
}
