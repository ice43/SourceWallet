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
    private var blurView: UIVisualEffectView?
    private var denominationView: DenominationView?
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
extension MainSettingsTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: 1
        case 1: 2
        case 2: 5
        case 3: 1
        default: 1
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
                    subtitle: selectedTimeout,
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
            default:
                cell = createTwoLineSettingCell(
                    tableView: tableView,
                    indexPath: indexPath,
                    title: "Support",
                    subtitle: "Version: 1.0.00",
                    hideChevronImage: true,
                    showCopyImage: true
                )
                
                let tapGesture = UITapGestureRecognizer(
                    target: self,
                    action: #selector(copyVersion)
                )
                
                cell.addGestureRecognizer(tapGesture)
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
        
        switch indexPath.section {
        case 0:
            logout()
            
        case 1:
            switch indexPath.row {
            case 0:
                showDenominationView()
            default:
                showWatchOnlyViewController()
            }
            
        case 2:
            switch indexPath.row {
            case 0:
                showPinViewController()
            case 1:
                enableFaceID(indexPath: indexPath)
            case 2:
                showTwoFactorAuthenticationViewController()
            case 3:
                showPgpViewController()
            default:
                showActionSheet()
            }
            
        case 3:
            showBeforeBackupViewController()
            
        default:
            print("Version of app has been copied to clipboard")
        }
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
        showCopyImage: Bool = false
    ) -> TwoLineSettingCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: twoLineSettingCellIdentifier,
            for: indexPath
        ) as?  TwoLineSettingCell else { return TwoLineSettingCell() }
        
        cell.titleLabel.text = title
        cell.subtitleLabel.text = subtitle
        cell.chevronImage.isHidden = hideChevronImage
        cell.copyImage.isHidden = !showCopyImage
        
        return cell
    }
    
    func enableFaceID(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? OneLineSettingCell {
            cell.switchButton.setOn(!cell.switchButton.isOn, animated: true)
            cell.switchValueChanged(cell.switchButton)
        }
    }
    
    @objc func copyVersion(_ sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? TwoLineSettingCell else { return }
        UIPasteboard.general.string = cell.subtitleLabel.text
        
        let alertController = UIAlertController(
            title: nil,
            message: "Сopied",
            preferredStyle: .alert
        )
        alertController.view.backgroundColor = .black.withAlphaComponent(0.7)
        alertController.view.alpha = 0.7
        alertController.view.layer.cornerRadius = 10
        
        present(alertController, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            alertController.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - DenominationViewDelegate
extension MainSettingsTableViewController: DenominationViewDelegate {
    func cancelButtonTapped() {
        blurView?.removeFromSuperview()
        denominationView?.removeFromSuperview()
        navigationController?.navigationBar.isHidden = false
    }
    
    func okButtonTapped() {
        blurView?.removeFromSuperview()
        denominationView?.removeFromSuperview()
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: - Navigation
private extension MainSettingsTableViewController {
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
    
    func showPinViewController() {
        let alertController = UIAlertController(
            title: "In progress",
            message: nil,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    func showDenominationView() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = view.bounds
        self.blurView = blurView
        blurView.alpha = 0
        
        let denominationView = DenominationView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width / 1.1,
                height: 300
            )
        )
        
        self.denominationView = denominationView
        
        denominationView.delegate = self
        denominationView.center = view.center
        denominationView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        view.addSubview(blurView)
        view.addSubview(denominationView)
        navigationController?.navigationBar.isHidden = true
        
        UIView.animate(withDuration: 0.3, animations: {
            blurView.alpha = 1
            denominationView.transform = CGAffineTransform.identity
        })
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
    
    func showBeforeBackupViewController() {
        guard let beforeBackupVC = storyboard?.instantiateViewController(
            withIdentifier: "BeforeBackupViewController"
        ) else { return }
        
        navigationController?.pushViewController(beforeBackupVC, animated: true)
    }
}
