//
//  AddNoteViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/3/24.
//

import UIKit

final class AddNoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setSheet()
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension AddNoteViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    func setSheet() {
        sheetPresentationController?.prefersGrabberVisible = true
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            280
        }
        sheetPresentationController?.detents = [detent]
    }
}
