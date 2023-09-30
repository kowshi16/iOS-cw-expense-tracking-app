//
//  ExpenseModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 24/09/2023.
//

import Foundation

struct Expense: Codable, Hashable {
    let _id: String
    let transTitle: String
    let description: String
    let amount: Int
    let transType: String
    let category: Category
    let location: String
    let transDate: String
}
