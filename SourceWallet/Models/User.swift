//
//  User.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/9/24.
//

import Foundation

struct User {
    let balance: String
    var fiat: String {
        String(format: "%.2f", (Double(balance) ?? 0) * 61467.65) + " USD"
    }
    
    static func getUser() -> User {
        let dataStore = DataStore.shared
        
        return User(
            balance: dataStore.balance.first ?? ""
        )
    }
}
