//
//  TypeRecoveryPhraseViewController.swift
//  SourceWallet
//
//  Created by Paul Makey on 7.06.24.
//

import UIKit

final class TypeRecoveryPhraseViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        setupTableView()
        setSheet()
    }
    
}

// MARK: - Private Methods
private extension TypeRecoveryPhraseViewController {
    func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableViewDataSource
extension TypeRecoveryPhraseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "NumberOfWordsCell",
            for: indexPath
        )
        
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.row {
            case 0: content.text = "12 words"
            default: content.text = "24 words"
        }
        
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TypeRecoveryPhraseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension TypeRecoveryPhraseViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    func setSheet() {
        sheetPresentationController?.prefersGrabberVisible = true
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            170
        }
        sheetPresentationController?.detents = [detent]
    }
}
