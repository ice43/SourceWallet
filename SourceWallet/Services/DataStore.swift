//
//  DataStore.swift
//  SourceWallet
//
//  Created by Serge Broski on 5/9/24.
//

import Foundation

final class DataStore {
    static let shared = DataStore()
    
    let types = [
        "Sent",
        "Received",
        "Received",
        "Sent",
        "Received",
        "Sent",
        "Received",
        "Sent",
        "Received",
        "Sent"
    ]
    
    let amounts = [
        "-0.00059868 BTC",
        "0.00013862 BTC",
        "0.00046562 BTC",
        "-0.00175814 BTC",
        "0.00161653 BTC",
        "-0.00135373 BTC",
        "0.00129858 BTC",
        "-0.00162038 BTC",
        "0.00160683 BTC",
        "-0.00462661 BTC"
    ]
    
    let dates = [
        "Jan 6, 2024",
        "Jan 6, 2024",
        "Jan 6, 2024",
        "Dec 23, 2023",
        "Dec 23, 2023",
        "Jul 21, 2023",
        "Jul 21, 2023",
        "Jul 2, 2023",
        "Jul 2, 2023",
        "Dec 29, 2022"
    ]
    
    let balance = [
        "0.00002343"
    ]
    
    private init() {}
}
