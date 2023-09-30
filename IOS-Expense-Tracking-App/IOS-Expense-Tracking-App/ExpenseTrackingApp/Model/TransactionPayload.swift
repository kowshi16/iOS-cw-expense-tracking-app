//
//  TransactionPayload.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import Foundation

struct TransactionPayload: Codable, Hashable {
    var transTitle: String
    var description: String
    var amount: Int
    var transType: String
    var category: Category
    var location: String
    var transDate: Date
}
