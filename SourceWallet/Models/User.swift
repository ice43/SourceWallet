//
//  User.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/9/24.
//

import Foundation

struct User {
    let seed: [[String]]
    var wallets: [Wallet]
    
    static func getUser() -> User {
        let dataStore = DataStore.shared
        let wallets = dataStore.walletsData
        let seedPhrase = dataStore.seedPhrase
        
        return User(
            seed: seedPhrase,
            wallets: wallets
        )
    }
}

struct Wallet: Equatable, Codable {
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

struct Transaction: Codable {
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

enum Denomination: String {
    case btc = "BTC"
    case mbtc = "mBTC"
    case ubtc = "µBTC"
    case bits = "bits"
    case sats = "sats"
    
    var multiplier: Double {
        switch self {
        case .btc:
            1
        case .mbtc:
            1000
        case .ubtc:
            1_000_000
        case .bits:
            1_000_000
        case .sats:
            100_000_000
        }
    }
}
