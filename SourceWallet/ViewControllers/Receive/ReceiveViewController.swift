//
//  ReceiveViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/12/24.
//

import UIKit

final class ReceiveViewController: UIViewController {
    @IBOutlet private weak var moreOptionsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMoreOptionsButton()
        
        title = "Receive"
    }
}

// MARK: - UI
private extension ReceiveViewController {
    func setupMoreOptionsButton() {
        moreOptionsButton.layer.borderWidth = 2
        moreOptionsButton.layer.borderColor = UIColor.white.cgColor
    }
}
