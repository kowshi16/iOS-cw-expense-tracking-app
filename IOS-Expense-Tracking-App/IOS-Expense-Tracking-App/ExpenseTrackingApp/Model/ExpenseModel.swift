//
//  ExpenseModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 24/09/2023.
//

import Foundation

struct Expense: Codable, Hashable {
    let _id: String
    let expenseTitle: String
    let description: String
    let category: Category
    let type: String
    let transDate: Date
    let amount: Double
    let location: String
}
