//
//  TransactionPayload.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import Foundation

struct TransactionPayload: Encodable {
    let transTitle: String
    let description: String
    let amount: Int
    let transType: String
    let category: Category?
    let location: String
    let transDate: Date
}
