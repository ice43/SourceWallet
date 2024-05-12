//
//  WalletPreferencesViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/11/24.
//

import UIKit

final class WalletPreferencesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private lazy var mainSettingsViewController: UINavigationController = {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "MainSettingsTableViewController") as? UINavigationController else { return UINavigationController() }
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setSheet()
    }
}

// MARK: - UI
private extension WalletPreferencesViewController {
    func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
    }
}

// MARK: - UITableViewDataSource
extension WalletPreferencesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WalletPreferenceCell") else {
            return UITableViewCell()
        }
        
        var content = cell.defaultContentConfiguration()
        content.textProperties.font = UIFont.systemFont(ofSize: 14)
        
        switch indexPath.row {
        case 0:
            content.text = "Create Account"
            content.image = UIImage(systemName: "cross.circle")
        case 1:
            content.text = "Settings"
            content.image = UIImage(systemName: "gearshape")
        default:
            content.text = "Logout"
            content.image = UIImage(systemName: "figure.walk")
        }
        
        cell.contentConfiguration = content
        cell.backgroundColor = .clear
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension WalletPreferencesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 1 {
            present(mainSettingsViewController, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

// MARK: - UISheetPresentationControllerDelegate
extension WalletPreferencesViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
    
    func setSheet() {
        sheetPresentationController?.prefersGrabberVisible = true
        
        let detent = UISheetPresentationController.Detent.custom { _ in
            240
        }
        sheetPresentationController?.detents = [detent]
    }
}
