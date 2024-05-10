//
//  SideMenuViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/10/24.
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func hideSideMenu()
}

final class SideMenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: SideMenuViewControllerDelegate?
    
    private let user = User.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    @IBAction func aboutButtonTapped() {
        delegate?.hideSideMenu()
    }
    
    @IBAction func appSettingsButtonTapped() {
        delegate?.hideSideMenu()
    }
}

// MARK: - UI
private extension SideMenuViewController {
    func setupTableView() {
        tableView.register(UINib(nibName: "WalletViewCell", bundle: nil), forCellReuseIdentifier: "WalletViewCell")
        tableView.backgroundColor = .none
    }
}

// MARK: - UITableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WalletViewCell") as? WalletViewCell else {
            return UITableViewCell()
        }
        
        let wallet = user.wallets[indexPath.row]
        
        cell.configureCell(withData: wallet)
        cell.backgroundColor = .clear
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedWallet = user.wallets[indexPath.row]
        
        guard let mainProfileVC = storyboard?.instantiateViewController(withIdentifier: "MainProfileViewController") as? MainProfileViewController else {
            return
        }
        
        mainProfileVC.selectedWallet = selectedWallet
        
        let navigationController = UINavigationController(rootViewController: mainProfileVC)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        present(navigationController, animated: true)
    }
}
