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

struct Wallet {
    let name: String
    let balance: String
    let transactions: [Transaction]
    
    var fiat: String {
        String(format: "%.2f", (Double(balance) ?? 0) * 61467.65) + " USD"
    }
}

struct Transaction {
    let type: String
    let amount: String
    let date: String
}
