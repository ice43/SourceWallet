//
//  MainProfileViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/7/24.
//

import UIKit

final class MainProfileViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var balanceLabel: UILabel!
    @IBOutlet private weak var fiatLabel: UILabel!
    @IBOutlet private weak var hideButton: UIButton!
    
    private let bottomMenuView = BottomMenuView()
    private let transactions = Transaction.getTransactions()
    private let user = User.getUser()
    private var isHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUserInfo()
        setupBottomMenu()
        setupTableView()
        
        setupLabelTapRecognition()
    }
    
    @IBAction func hideButtonTapped(_ sender: UIButton) {
        isHidden.toggle()
        
        for cell in tableView.visibleCells {
            guard let transactionCell = cell as? TransactionViewCell else { return }
            
            if isHidden {
                balanceLabel.text = "*****"
                fiatLabel.text = "*****"
                transactionCell.hideAmountLabel()
                
                let closedEyeImage = UIImage(named: "closed_eye")?.resized(
                    to: CGSize(width: 30, height: 25)
                )
                sender.setImage(closedEyeImage, for: .normal)
            } else {
                balanceLabel.text = user.balance + " BTC"
                fiatLabel.text = user.fiat
                transactionCell.showAmountLabel()
                
                sender.setImage(UIImage(systemName: "eye"), for: .normal)
            }
        }
    }
}

// MARK: - UI
private extension MainProfileViewController {
    func setupUserInfo() {
        balanceLabel.text = user.balance + " BTC"
        fiatLabel.text = user.fiat
    }
    
    func setupBottomMenu() {
        bottomMenuView.translatesAutoresizingMaskIntoConstraints = false
        bottomMenuView.layer.cornerRadius = 10
        view.addSubview(bottomMenuView)
        
        // Setting up constraints
        NSLayoutConstraint.activate(
            [
                bottomMenuView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: 20
                ),
                bottomMenuView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -20
                ),
                bottomMenuView.bottomAnchor.constraint(
                    equalTo: view.bottomAnchor,
                    constant: -40
                ),
                bottomMenuView.heightAnchor.constraint(
                    equalToConstant: 50
                )
            ]
        )
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "TransactionViewCell", bundle: nil), forCellReuseIdentifier: "TransactionViewCell")
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .none
    }
}

// MARK: - Labels interaction
private extension MainProfileViewController {
    func setupLabelTapRecognition() {
        let balanceLabelTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(labelTapped)
        )
        balanceLabel.addGestureRecognizer(balanceLabelTapGesture)
        balanceLabel.isUserInteractionEnabled = true
        
        let fiatLabelTapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(labelTapped)
        )
        fiatLabel.addGestureRecognizer(fiatLabelTapGesture)
        fiatLabel.isUserInteractionEnabled = true
    }
    
    @objc func labelTapped() {
        let tempText = balanceLabel.text
        balanceLabel.text = fiatLabel.text
        fiatLabel.text = tempText
    }
}

// MARK: - UITableViewDataSource
extension MainProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionViewCell") as? TransactionViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(withData: transactions[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension MainProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
