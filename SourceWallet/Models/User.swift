//
//  User.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/9/24.
//

import Foundation

struct User {
    let seed: [String]
    let wallets: [Wallet]
    
    static func getUser() -> User {
        let dataStore = DataStore.shared
        let wallets = dataStore.walletsData
        
        return User(
            seed: dataStore.seed,
            wallets: wallets
        )
    }
}

struct Wallet: Equatable {
    let name: String
    let address: String
    let balance: String
    let transactions: [Transaction]
    
    var fiat: String {
        String(format: "%.2f", (Double(balance) ?? 0) * 61467.65) + " USD"
    }
    var isSelected = false
    
    // This is necessary to determine whether to display a dot above the selected wallet
    static func ==(lhs: Wallet, rhs: Wallet) -> Bool {
        return lhs.name == rhs.name
        && lhs.isSelected == rhs.isSelected
    }
}

struct Transaction {
    let type: String
    let amount: String
    let date: String
    let id: String
    var destination: String? = nil
    var fee: String? = nil
    var feeRate: String? = nil
    
    var fiat: String {
        String(format: "%.2f", (Double(amount) ?? 0) * 61467.65) + " USD"
    }
}
