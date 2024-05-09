//
//  Transaction.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/7/24.
//

import Foundation

struct Transaction {
    let type: String
    let amount: String
    let date: String
    
    static func getTransactions() -> [Transaction] {
        let dataStore = DataStore.shared
        
        let types = dataStore.types
        let amounts = dataStore.amounts
        let dates = dataStore.dates
        
        let iterationCount = min(
            types.count,
            amounts.count,
            dates.count
        )
        
        return (0..<iterationCount).map { index in
            Transaction(
                type: types[index],
                amount: amounts[index],
                date: dates[index]
            )
        }
    }
}
