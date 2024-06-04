//
//  SecureFundsViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/5/24.
//

import UIKit

final class SecureFundsViewController: UIViewController {
    @IBOutlet private weak var watchOnlyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setWatchOnlyButton()
    }
    
    // MARK: IB Actions
    @IBAction private func dismiss() {
        dismiss(animated: true)
    }
    
    @IBAction private func watchOnlyButtonTapped() {
        guard let watchOnlyVC = storyboard?.instantiateViewController(
            withIdentifier: "WatchOnlyViewController"
        ) else { return }
        
        navigationController?.pushViewController(watchOnlyVC, animated: true)
    }
}

// MARK: - UI
private extension SecureFundsViewController {
    func setupViews() {
        let onThisDeviceView = StorageFunds(
            frame: CGRect(
                x: 20,
                y: 210,
                width: view.frame.width - 40,
                height: 220
            )
        )
        onThisDeviceView.titleLabel.text = "On This Device"
        onThisDeviceView.descriptionLabel.text = "Your phone will store the keys to your bitcoin, PIN protected."
        onThisDeviceView.securityLabel.text = "For Ease of Use"
        onThisDeviceView.backgroundColor = .backModal
        onThisDeviceView.layer.cornerRadius = 10
        onThisDeviceView.button.addTarget(
            self,
            action: #selector(onThisDeviceViewButtonTapped),
            for: .touchUpInside
        )
        view.addSubview(onThisDeviceView)
        
        let onHardwareWalletView = StorageFunds(
            frame: CGRect(
                x: 20,
                y: onThisDeviceView.frame.maxY + 30,
                width: view.frame.width - 40,
                height: 220
            )
        )
        onHardwareWalletView.titleLabel.text = "On Hardware Wallet"
        onHardwareWalletView.descriptionLabel.text = "Your keys will be secured on a dedicated cold storage device, PIN protected."
        onHardwareWalletView.securityLabel.text = "For Higher Security"
        onHardwareWalletView.backgroundColor = .backModal
        onHardwareWalletView.layer.cornerRadius = 10
        onHardwareWalletView.button.addTarget(
            self,
            action: #selector(onHardwareWalletViewButtonTapped),
            for: .touchUpInside
        )
        view.addSubview(onHardwareWalletView)
    }
    
    func setWatchOnlyButton() {
        watchOnlyButton.layer.borderWidth = 2
        watchOnlyButton.layer.borderColor = UIColor.white.cgColor
    }
}

// MARK: - Navigation
private extension SecureFundsViewController {
    @objc func onThisDeviceViewButtonTapped() {
        guard let restoreOrNewVC = storyboard?.instantiateViewController(withIdentifier: "RestoreOrNew") as? RestoreOrNewViewController else { return }
        
        navigationController?.pushViewController(restoreOrNewVC, animated: true)
    }
    
    @objc func onHardwareWalletViewButtonTapped() {
        let alertController = UIAlertController(
            title: "Not found",
            message: "This way is temporarily not supported",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
