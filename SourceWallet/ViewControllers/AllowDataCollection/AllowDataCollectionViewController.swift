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
    @IBOutlet private weak var chevronImage: UIImageView!
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
                x: self.collectButtonStack.frame.origin.x,
                y: self.showDetailsButton.frame.maxY + 30,
                width: self.showDetailsButton.frame.width,
                height: self.isTableViewExpanded ? 238 : 0
            )
            
            self.learnMoreButton.frame.origin.y = self.whatsCollectedView.frame.maxY
            self.collectButtonStack.frame.origin.y = self.whatsCollectedView.frame.maxY
            self.chevronImage.image = UIImage(systemName: self.isTableViewExpanded ? "chevron.up" : "chevron.down")
        }
    }
    
    @IBAction private func learnMoreButtonPressed() {
        guard let url = URL(string: "https://www.hackingwithswift.com") else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - UI
private extension AllowDataCollectionViewController {
    func setWhatsCollectedTable() {
        whatsCollectedView = WhatsCollectedView()
        
        whatsCollectedView.frame = CGRect(
            x: collectButtonStack.frame.origin.x,
            y: showDetailsButton.frame.maxY + 30,
            width: showDetailsButton.frame.width,
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
        learnMoreButton.frame.origin.y = whatsCollectedView.frame.maxY + 20
        collectButtonStack.frame.origin.y = whatsCollectedView.frame.maxY + 100
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            self.isTableViewExpanded ? 680 : 450
        }
        
        sheetPresentationController?.animateChanges {
            self.sheetPresentationController?.detents = [detent]
        }
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension AllowDataCollectionViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    private func setSheet() {
        sheetPresentationController?.delegate = self
        sheetPresentationController?.prefersGrabberVisible = true
    }
}
