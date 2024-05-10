//
//  DataStore.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/9/24.
//

import Foundation

final class DataStore {
    static let shared = DataStore()
    
    let seed = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10",
        "11",
        "12",
        "13",
        "14",
        "15",
        "16",
        "17",
        "18",
        "19",
        "20",
        "21",
        "22",
        "23",
        "24"
    ]
    
    let walletsData: [Wallet] = [
        Wallet(
            name: "Main wallet",
            balance: "0.00002343",
            transactions: [
                Transaction(
                    type: "Sent",
                    amount: "-0.00059868 BTC",
                    date: "Jan 6, 2024"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00013862 BTC",
                    date: "Jan 6, 2024"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00046562 BTC",
                    date: "Jan 6, 2024"
                ),
                Transaction(
                    type: "Sent",
                    amount: "-0.00175814 BTC",
                    date: "Dec 23, 2023"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00161653 BTC",
                    date: "Dec 23, 2023"
                ),
                Transaction(
                    type: "Sent",
                    amount: "-0.00135373 BTC",
                    date: "Jul 21, 2023"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00129858 BTC",
                    date: "Jul 21, 2023"
                ),
                Transaction(
                    type: "Sent",
                    amount: "-0.00162038 BTC",
                    date: "Jul 2, 2023"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00160683 BTC",
                    date: "Jul 2, 2023"
                ),
                Transaction(
                    type: "Sent",
                    amount: "-0.00462661 BTC",
                    date: "Dec 29, 2022"
                )
            ]
        ),
        Wallet(
            name: "Reserve",
            balance: "1.02345464",
            transactions: [
                Transaction(
                    type: "Sent",
                    amount: "-0.00182335 BTC",
                    date: "Apr 19, 2024"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.04184832 BTC",
                    date: "Jan 12, 2024"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.03563267 BTC",
                    date: "Dec 24, 2023"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.02770233 BTC",
                    date: "Sep 8, 2023"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.02165684 BTC",
                    date: "Jul 30, 2023"
                )
            ]
        )
    ]
    
    private init() {}
}
