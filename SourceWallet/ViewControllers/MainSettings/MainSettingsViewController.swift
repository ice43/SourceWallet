//
//  MainSettingsViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/11/24.
//

import UIKit

final class MainSettingsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let oneLineSettingCellIdentifier = "OneLineSettingCell"
    private let twoLineSettingCellIdentifier = "TwoLineSettingCell"
    private var selectedTimeout = "5 minutes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        hideBackBarButton()
    }
    
    @IBAction private func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - UI
private extension MainSettingsViewController {
    func setupTableView() {
        tableView.backgroundColor = .back
        tableView.register(
            UINib(
                nibName: oneLineSettingCellIdentifier,
                bundle: nil
            ),
            forCellReuseIdentifier: oneLineSettingCellIdentifier
        )
        tableView.register(
            UINib(
                nibName: twoLineSettingCellIdentifier,
                bundle: nil
            ),
            forCellReuseIdentifier: twoLineSettingCellIdentifier
        )
    }
    
    func hideBackBarButton() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}

// MARK: - UITableViewDataSource
extension MainSettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: 1
        case 1: 1
        default: 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        switch indexPath.section {
        case 0:
            cell = createTwoLineSettingCell(
                tableView: tableView,
                indexPath: indexPath,
                title: "Wallet",
                subtitle: "Log out"
            )
            
        case 1:
            cell = createOneLineSettingCell(
                tableView: tableView,
                indexPath: indexPath,
                title: "Watch only"
            )
            
        default:
            switch indexPath.row {
            case 0:
                cell = createOneLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Change PIN"
                )
                
            case 1:
                cell = createOneLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Face ID",
                    hideChevronImage: true,
                    showSwitch: true
                )
                
            case 2:
                cell = createOneLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Two-Factor authentication"
                )
                
            case 3:
                cell = createOneLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "PGP key"
                )
                
            default:
                cell = createTwoLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Auto logout timeout",
                    subtitle: selectedTimeout,
                    hideChevronImage: true
                )
            }
        }
        
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            "Account"
        case 1:
            "General"
        default:
            "Security"
        }
    }
}

// MARK: - UITableViewDelegate
extension MainSettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            logout()
            
        case 1:
            showWatchOnlyViewController()
            
        default:
            switch indexPath.row {
            case 0:
                showSetPinViewController()
            case 1:
                enableFaceID(indexPath: indexPath)
            case 2:
                showTwoFactorAuthenticationViewController()
            case 3:
                showPgpViewController()
            default:
                showActionSheet()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}

// MARK: - Private methods
private extension MainSettingsViewController {
    func createOneLineSettingCell(
        tableView: UITableView,
        indexPath: IndexPath,
        title: String,
        hideChevronImage: Bool = false,
        showSwitch: Bool = false
    ) -> OneLineSettingCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: oneLineSettingCellIdentifier,
            for: indexPath
        ) as? OneLineSettingCell else { return OneLineSettingCell() }
        
        cell.titleLabel.text = title
        cell.chevronImage.isHidden = hideChevronImage
        cell.switchButton.isHidden = !showSwitch
        
        return cell
    }
    
    func createTwoLineSettingCell(
        tableView: UITableView,
        indexPath: IndexPath,
        title: String,
        subtitle: String,
        hideChevronImage: Bool = false
    ) -> TwoLineSettingCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: twoLineSettingCellIdentifier,
            for: indexPath
        ) as?  TwoLineSettingCell else { return TwoLineSettingCell() }
        
        cell.titleLabel.text = title
        cell.subtitleLabel.text = subtitle
        cell.chevronImage.isHidden = hideChevronImage
        
        return cell
    }
    
    func enableFaceID(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? OneLineSettingCell {
            cell.switchButton.setOn(!cell.switchButton.isOn, animated: true)
            cell.switchValueChanged(cell.switchButton)
        }
    }
}

// MARK: - Navigation
private extension MainSettingsViewController {
    func logout() {
        guard let welcomeVC = storyboard?.instantiateViewController(
            withIdentifier: "WelcomeViewController"
        ) else { return }
        
        welcomeVC.modalTransitionStyle = .crossDissolve
        welcomeVC.modalPresentationStyle = .fullScreen
        
        present(welcomeVC, animated: true)
    }
    
    func showWatchOnlyViewController() {
        guard let watchOnlyVC = storyboard?.instantiateViewController(
            withIdentifier: "WatchOnlyViewController"
        ) else { return }
        
        navigationController?.pushViewController(watchOnlyVC, animated: true)
    }
    
    func showSetPinViewController() {
        guard let setPinVC = storyboard?.instantiateViewController(
            withIdentifier: "SetPinViewController"
        ) else { return }
        
        navigationController?.pushViewController(setPinVC, animated: true)
    }
    
    func showTwoFactorAuthenticationViewController() {
        guard let twoFactorAuthenticationVC = storyboard?.instantiateViewController(
            withIdentifier: "TwoFactorAuthenticationViewController"
        ) else { return }
        
        navigationController?.pushViewController(twoFactorAuthenticationVC, animated: true)
    }
    
    func showPgpViewController() {
        guard let pgpVC = storyboard?.instantiateViewController(
            withIdentifier: "PgpViewController"
        ) else { return }
        
        navigationController?.pushViewController(pgpVC, animated: true)
    }
    
    func showActionSheet() {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let oneMinuteAction = UIAlertAction(
            title: "1 minute",
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            
            selectedTimeout = "1 minute"
            tableView.reloadData()
        }
        alertController.addAction(oneMinuteAction)
        
        let twoMinutesAction = UIAlertAction(
            title: "2 minutes",
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            
            selectedTimeout = "2 minutes"
            tableView.reloadData()
        }
        alertController.addAction(twoMinutesAction)
        
        let fiveMinutesAction = UIAlertAction(
            title: "5 minutes",
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            
            selectedTimeout = "5 minutes"
            tableView.reloadData()
        }
        alertController.addAction(fiveMinutesAction)
        
        let tenMinutesAction = UIAlertAction(
            title: "10 minutes",
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            
            selectedTimeout = "10 minutes"
            tableView.reloadData()
        }
        alertController.addAction(tenMinutesAction)
        
        let sixtyMinutesAction = UIAlertAction(
            title: "60 minutes",
            style: .default
        ) { [weak self] _ in
            guard let self else { return }
            
            selectedTimeout = "60 minutes"
            tableView.reloadData()
        }
        alertController.addAction(sixtyMinutesAction)
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
