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
            address: "3A6hYSrR26Za5NcHrMNDL0mAN5e7U1Pk2i",
            balance: "0.00002343",
            transactions: [
                Transaction(
                    type: "Sent",
                    amount: "-0.00059868",
                    date: "Jan 6, 2024",
                    id: "dc223df5e81b0557076f7d2d68dfd3e2e482fd2a3d8bf06312e43fcf1f6b369d",
                    destination: "3HZAQVq7sHEXmjwuYB9ufW5Mku6cd9FTdm",
                    fee: "0.00018938 BTC ≈ 12.88 USD",
                    feeRate: "55.86 satoshi / vbyte"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00013862",
                    date: "Jan 6, 2024",
                    id: "4b93cd8f8bf7748313455aaed45832d4750799123c72a330a6c101c453d9eaea"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00046562",
                    date: "Jan 6, 2024",
                    id: "6c4e7aeff60ef331f72633c90ce2ee4216c666edb7f33f717da800c12b280620"
                ),
                Transaction(
                    type: "Sent",
                    amount: "-0.00175814",
                    date: "Dec 23, 2023",
                    id: "aacf93ade76c7ac98a3fea0a5303a5f19a260ce8436a2b980d23f29420173cd9",
                    destination: "3EnwX3ssPwS8tgud3Y4edz2KZea5thzgSC",
                    fee: "0.00045495 BTC ≈ 30.94 USD",
                    feeRate: "148.86 satoshi / vbyte"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00161653",
                    date: "Dec 23, 2023",
                    id: "48672c141e4a3ea10c92ae1bb7f89560a39769a5b7af6bd0ed43049fb531fbc6"
                ),
                Transaction(
                    type: "Sent",
                    amount: "-0.00135373",
                    date: "Jul 21, 2023",
                    id: "0d276bac671c846f649c7877b227bcd41b909ac4d745185b0e03403c11c34e8b",
                    destination: "3KPaXKf8budpKnhCEg2BPBizT5h9ny9jEe",
                    fee: "0.00008373 BTC ≈ 5.69 USD",
                    feeRate: "24.77 satoshi / vbyte"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00129858",
                    date: "Jul 21, 2023",
                    id: "c5277b0c1471c26f8f84a7943154279ddf4dcdd308f94ef4ddfcbf4e6e057435"
                ),
                Transaction(
                    type: "Sent",
                    amount: "-0.00162038",
                    date: "Jul 2, 2023",
                    id: "d60e39638e182b2adce85efc2bea4c0f7ca9a8366a3b6022a2de8d3072d094cb",
                    destination: "3MvV7R3GKXc5EwTGGyh6wsZyHFMDoHBSGM",
                    fee: "0.00004038 BTC ≈ 2.75 USD",
                    feeRate: "11.95 satoshi / vbyte"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.00160683",
                    date: "Jul 2, 2023",
                    id: "3fedb58247eab5a4df3c67e156c63bdaa556af8b7c84b432ad4bf900e1d5525d"
                ),
                Transaction(
                    type: "Sent",
                    amount: "-0.00462661",
                    date: "Dec 29, 2022",
                    id: "4b0aee79e388f501c5109bbd318dfbdee0aed3a652e624daae32925b0e3a3ec3",
                    destination: "31uBwHKDrUTdAcSb8q8qdmZAp9y8rGNCJa",
                    fee: "0.00000661 BTC ≈ 0.45 USD",
                    feeRate: "1.95 satoshi / vbyte"
                )
            ]
        ),
        Wallet(
            name: "Reserve",
            address: "3NUzSxSTdvngNfMoK8lmrGQL3K8DYX5EMy",
            balance: "1.02345464",
            transactions: [
                Transaction(
                    type: "Sent",
                    amount: "-0.00182335",
                    date: "Apr 19, 2024",
                    id: "873b52c95df03d559d4071ea57b054e4b1d69d69c7c0ced81851af7a519266b3",
                    destination: "34SKKYTKn26a1c5hQQ6N82aQWQDLJxRXSK",
                    fee: "0.00009259 BTC ≈ 5.72 USD",
                    feeRate: "25.97 satoshi / vbyte"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.04184832",
                    date: "Jan 12, 2024",
                    id: "89dec36048239c729eefab32142bca2fc5403d07bd577c5f37afd729907b841a"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.03563267",
                    date: "Dec 24, 2023",
                    id: "6dcef05116a8230ecf5fb59caf23c6dfd892b0cda299dfd17117f3d887545063"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.02770233",
                    date: "Sep 8, 2023",
                    id: "da354c629674bcec2a854cfb74ff6bc536c5512bc5497c93682ca86cdab7a2d9"
                ),
                Transaction(
                    type: "Received",
                    amount: "0.02165684",
                    date: "Jul 30, 2023",
                    id: "c9641e7eccf71a567a3063ea382e57ed1bd3f2536d38abd58b48dd319239abca"
                )
            ]
        )
    ]
    
    private init() {}
}
