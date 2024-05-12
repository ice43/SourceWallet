//
//  MainSettingsTableViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/11/24.
//

import UIKit

final class MainSettingsTableViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    private let oneLineSettingCellIdentifier = "OneLineSettingCell"
    private let twoLineSettingCellIdentifier = "TwoLineSettingCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    @IBAction private func closeButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

// MARK: - UI
private extension MainSettingsTableViewController {
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
}

// MARK: - UITableViewDataSource
extension MainSettingsTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: 1
        case 1: 3
        case 2: 5
        case 3: 1
        default: 2
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
            switch indexPath.row {
            case 0:
                cell = createTwoLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Denominations & Exchange Rate",
                    subtitle: "Change references",
                    hideChevronImage: true
                )
                
            case 1:
                cell = createOneLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Archived Accounts"
                )
                
            default:
                cell = createOneLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Watch only"
                )
            }
            
        case 2:
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
                    subtitle: "5 minutes",
                    hideChevronImage: true
                )
            }
            
        case 3:
            cell = createTwoLineSettingCell(
                tableView: tableView,
                indexPath: indexPath,
                title: "Back Up Recovery Phrase",
                subtitle: "Touch to display"
            )
            
        default:
            switch indexPath.row {
            case 0:
                cell = createTwoLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Version",
                    subtitle: "Version: 1.0.00",
                    hideChevronImage: true
                )
                
            default:
                cell = createTwoLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Support",
                    subtitle: "Copy support ID",
                    hideChevronImage: true,
                    showCopyButton: true
                )
            }
        }
        
        cell.layer.cornerRadius = 10
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            "General"
        case 2:
            "Security"
        case 3:
            "Recovery"
        default:
            "About"
        }
    }
}

// MARK: - UITableViewDelegate
extension MainSettingsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}

// MARK: - Private methods
private extension MainSettingsTableViewController {
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
        hideChevronImage: Bool = false,
        showCopyButton: Bool = false
    ) -> TwoLineSettingCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: twoLineSettingCellIdentifier,
            for: indexPath
        ) as?  TwoLineSettingCell else { return TwoLineSettingCell() }
        
        cell.titleLabel.text = title
        cell.subtitleLabel.text = subtitle
        cell.chevronImage.isHidden = hideChevronImage
        cell.copyButton.isHidden = !showCopyButton
        
        return cell
    }
}
