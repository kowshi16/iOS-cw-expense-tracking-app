//
//  ReportsModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import Foundation

struct TransactionReport: Codable, Hashable {
    let _id: String
    let transTitle: String
    let description: String
    let amount: Int
    let transType: String
    let category: Category
    let location: String
    let transDate: String
}

struct CategoryPercentageReport: Codable, Hashable {
    let _id: String
    let transTitle: String
    let description: String
    let amount: Int
    let transType: String
    let category: Category
    let location: String
    let transDate: String
    let percentage: Int
}
