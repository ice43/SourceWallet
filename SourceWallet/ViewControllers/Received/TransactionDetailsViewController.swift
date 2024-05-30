//
//  TransactionDetailsViewController.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/24/24.
//

import UIKit

final class TransactionDetailsViewController: UIViewController {
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var amountLabel: UILabel!
    @IBOutlet private weak var fiatLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var feeLabel: UILabel!
    @IBOutlet private weak var feeRateLabel: UILabel!
    @IBOutlet private weak var destinationLabel: UILabel!
    
    @IBOutlet private weak var receivedStack: UIStackView!
    @IBOutlet private weak var sendStack: UIStackView!
    
    @IBOutlet private weak var receivedConstraint: NSLayoutConstraint!
    @IBOutlet private weak var sentConstraint: NSLayoutConstraint!
    
    var transaction: Transaction?
    var selectedWallet: Wallet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting stack visibility depending on the type of transaction
        setupStack()
        
        // Filling the stack with information
        setupInfo()
    }
}

// MARK: - UI
private extension TransactionDetailsViewController {
    func setupStack() {
        switch transaction?.type {
        case "Received":
            sendStack.isHidden = true
            
            sentConstraint.isActive = false
            receivedConstraint.isActive = true
        default:
            receivedStack.isHidden = true
            
            sentConstraint.isActive = true
            receivedConstraint.isActive = false
        }
    }
    
    func setupInfo() {
        guard let transaction = transaction else { return }
        
        infoLabel.text = "Your transaction was successfully \(transaction.type.lowercased())"
        amountLabel.text = transaction.amount + " BTC"
        dateLabel.text = transaction.date
        fiatLabel.text = "≈ " + transaction.fiat
        statusLabel.text = transaction.type
        idLabel.text = transaction.id
        feeLabel.text = transaction.fee
        feeRateLabel.text = transaction.feeRate
        destinationLabel.text = transaction.destination
        
        guard let selectedWallet = selectedWallet else { return }
        
        sourceLabel.text = selectedWallet.address
    }
}
