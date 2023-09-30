//
//  BudgetModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import Foundation

struct Budget: Codable, Hashable {
    let _id: String
    let budgetTitle: String
    let amount: Int
    let category: Category
    let budgetType: String
}
