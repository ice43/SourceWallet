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
    var selectedWallet: Wallet?
    
    private var user = User.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        loadWallets()
    }
    
    @IBAction private func aboutButtonTapped() {
        delegate?.hideSideMenu()
    }
    
    @IBAction private func appSettingsButtonTapped() {
        delegate?.hideSideMenu()
    }
    
    @IBAction func setupNewWalletButtonTapped() {
        delegate?.hideSideMenu()
    }
}

// MARK: - UI
private extension SideMenuViewController {
    func setupTableView() {
        tableView.register(
            UINib(nibName: "WalletViewCell", bundle: nil),
            forCellReuseIdentifier: "WalletViewCell"
        )
        tableView.backgroundColor = .none
    }
}

// MARK: - UITableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.wallets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "WalletViewCell"
        ) as? WalletViewCell else { return UITableViewCell() }
        
        let wallet = user.wallets[indexPath.row]
        let isSelected = (wallet == selectedWallet)
        cell.configureCell(withData: wallet, isSelected: isSelected)
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
        
        selectedWallet = user.wallets[indexPath.row]
        
        guard let mainProfileVC = storyboard?.instantiateViewController(
            withIdentifier: "MainProfileViewController"
        ) as? MainProfileViewController else { return }
        
        mainProfileVC.selectedWallet = selectedWallet
        
        let navigationController = UINavigationController(rootViewController: mainProfileVC)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        present(navigationController, animated: true)
    }
}

// MARK: - Navigation
extension SideMenuViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addWalletVC = segue.destination as? AddWalletViewController {
            addWalletVC.onWalletAdded = { [weak self] walletName in
                self?.addNewWallet(withName: walletName)
            }
        }
    }
}

// MARK: - Private methods
private extension SideMenuViewController {
    func addNewWallet(withName name: String) {
        let newWallet = Wallet(
            name: name,
            address: "",
            balance: "0",
            transactions: []
        )
        user.wallets.append(newWallet)
        
        saveWallets()
        tableView.reloadData()
    }

    func loadWallets() {
        if let savedWalletsData = UserDefaults.standard.data(forKey: "SavedWallets"),
           let decodedWallets = try? JSONDecoder().decode([Wallet].self, from: savedWalletsData) {
            user.wallets = decodedWallets
        }
        tableView.reloadData()
    }
    
    func saveWallets() {
        if let encodedWallets = try? JSONEncoder().encode(user.wallets) {
            UserDefaults.standard.set(encodedWallets, forKey: "SavedWallets")
        }
    }
}
