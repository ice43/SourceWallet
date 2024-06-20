//
//  CreateAccountViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 6/19/24.
//

import UIKit

final class CreateAccountViewController: UIViewController {
    @IBOutlet private weak var topStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

// MARK: - UI
private extension CreateAccountViewController {
    func setupViews() {
        let standardPolicyView = Policy()
        standardPolicyView.translatesAutoresizingMaskIntoConstraints = false
        standardPolicyView.titleLabel.text = "Standard"
        standardPolicyView.descriptionLabel.text = "Cheaper singlesig option. Addresses are Native SegWit Bech32"
        standardPolicyView.backgroundColor = .backModal
        standardPolicyView.layer.cornerRadius = 10
        standardPolicyView.button.addTarget(
            self,
            action: #selector(standardPolicyViewButtonTapped),
            for: .touchUpInside
        )
        view.addSubview(standardPolicyView)
        
        let protectedPolicyView = Policy()
        protectedPolicyView.translatesAutoresizingMaskIntoConstraints = false
        protectedPolicyView.typeLabel.text = "MULTISIG"
        protectedPolicyView.titleLabel.text = "2FA Protected"
        protectedPolicyView.descriptionLabel.text = "Quick setup 2FA account, ideal for active spenders"
        protectedPolicyView.backgroundColor = .backModal
        protectedPolicyView.layer.cornerRadius = 10
        protectedPolicyView.button.addTarget(
            self,
            action: #selector(protectedPolicyViewButtonTapped),
            for: .touchUpInside
        )
        view.addSubview(protectedPolicyView)
        
        NSLayoutConstraint.activate(
            [
                standardPolicyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                standardPolicyView.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 40),
                standardPolicyView.widthAnchor.constraint(equalToConstant: topStack.frame.width),
                standardPolicyView.heightAnchor.constraint(equalToConstant: 180),
                
                protectedPolicyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                protectedPolicyView.topAnchor.constraint(equalTo: standardPolicyView.bottomAnchor, constant: 30),
                protectedPolicyView.widthAnchor.constraint(equalTo: standardPolicyView.widthAnchor),
                protectedPolicyView.heightAnchor.constraint(equalTo: standardPolicyView.heightAnchor),
            ]
        )
    }
}

// MARK: - Navigation
private extension CreateAccountViewController {
    @objc func standardPolicyViewButtonTapped() {
        guard let setPinVC = storyboard?.instantiateViewController(withIdentifier: "SetPinViewController") else { return }
        
        
        navigationController?.pushViewController(setPinVC, animated: true)
    }
    
    @objc func protectedPolicyViewButtonTapped() {
        let alertController = UIAlertController(
            title: nil,
            message: "This way is temporarily not supported",
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
