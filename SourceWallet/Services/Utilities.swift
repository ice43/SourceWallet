//
//  Utilities.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/21/24.
//

import UIKit

final class Utilities: UIViewController {
    
    static func showAlertControllerUnsupportedAction(for viewController: UIViewController) {
        let alertController = UIAlertController(
            title: nil,
            message: "This way is temporarily unsupported",
            preferredStyle: .alert
        )
        alertController.view.backgroundColor = .black.withAlphaComponent(0.7)
        alertController.view.alpha = 0.7
        alertController.view.layer.cornerRadius = 10
        
        viewController.present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}
