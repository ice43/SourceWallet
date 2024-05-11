//
//  AboutViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/11/24.
//

import UIKit

final class AboutViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setSheet()
    }
    
    @IBAction func actualLinkButtonsTapped() {
        guard let url = URL(string: "https://www.hackingwithswift.com") else { return }
        UIApplication.shared.open(url)
    }
}

// MARK: - UI
private extension AboutViewController {
    func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableViewDataSource
extension AboutViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell") else {
            return UITableViewCell()
        }
        
        var content = cell.defaultContentConfiguration()
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        
        switch indexPath.row {
        case 0:
            content.text = "Give us your feedback"
        case 1:
            content.text = "Visit the SourceWallet Help Center"
        case 2:
            content.text = "Terms of Service"
        default:
            content.text = "Privacy Policy"
        }
        
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension AboutViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let url = URL(string: "https://www.hackingwithswift.com") else { return }
        UIApplication.shared.open(url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension AboutViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    func setSheet() {
        sheetPresentationController?.prefersGrabberVisible = true
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            550
        }
        sheetPresentationController?.detents = [detent]
    }
}
