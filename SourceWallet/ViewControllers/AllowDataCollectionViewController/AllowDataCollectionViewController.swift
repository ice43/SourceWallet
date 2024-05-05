//
//  AllowDataCollectionViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/3/24.
//

import UIKit

final class AllowDataCollectionViewController: UIViewController {
    // MARK: IB Outlets
    @IBOutlet private weak var showDetailsButton: UIButton!
    @IBOutlet private weak var learnMoreButton: UIButton!
    @IBOutlet private weak var dontCollectDataButton: UIButton!
    @IBOutlet private weak var collectButtonStack: UIStackView!
    
    // MARK: Private properties
    private var whatsCollectedView: WhatsCollectedView!
    private var isTableViewExpanded = false
    
    // MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSheet()
        
        setWhatsCollectedTable()
        setDontCollectDataButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updatePositions()
    }
    
    // MARK: IB Actions
    @IBAction private func showDetailsButtonPressed(_ sender: UIButton) {
        isTableViewExpanded.toggle()
        
        UIView.animate(withDuration: 0.5) {
            self.whatsCollectedView.frame = CGRect(
                x: 27,
                y: self.showDetailsButton.frame.maxY,
                width: self.showDetailsButton.frame.maxX,
                height: self.isTableViewExpanded ? 238 : 0
            )
            
            self.learnMoreButton.frame.origin.y = self.whatsCollectedView.frame.maxY
            self.collectButtonStack.frame.origin.y = self.whatsCollectedView.frame.maxY
        }
    }
}

// MARK: - UI
private extension AllowDataCollectionViewController {
    func setWhatsCollectedTable() {
        whatsCollectedView = WhatsCollectedView()
        
        whatsCollectedView.frame = CGRect(
            x: 27,
            y: showDetailsButton.frame.maxY,
            width: showDetailsButton.frame.maxX,
            height: 0
        )
        
        whatsCollectedView.layer.cornerRadius = 10
        whatsCollectedView.layer.masksToBounds = true
        
        view.addSubview(whatsCollectedView)
    }
    
    func setDontCollectDataButton() {
        dontCollectDataButton.layer.borderWidth = 2
        dontCollectDataButton.layer.borderColor = UIColor.white.cgColor
    }
    
    func updatePositions() {
        self.learnMoreButton.frame.origin.y = self.whatsCollectedView.frame.maxY + 25
        self.collectButtonStack.frame.origin.y = self.whatsCollectedView.frame.maxY + 100
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            self.isTableViewExpanded ? 650 : 420
        }
        self.sheetPresentationController?.animateChanges {
            self.sheetPresentationController?.detents = [detent]
        }
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension AllowDataCollectionViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    func setSheet() {
        sheetPresentationController?.delegate = self
        sheetPresentationController?.prefersGrabberVisible = true
    }
}
