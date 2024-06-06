//
//  QrViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/13/24.
//

import UIKit

final class QrViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setSheet()
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension QrViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    func setSheet() {
        sheetPresentationController?.prefersGrabberVisible = true
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            540
        }
        sheetPresentationController?.detents = [detent]
    }
}
