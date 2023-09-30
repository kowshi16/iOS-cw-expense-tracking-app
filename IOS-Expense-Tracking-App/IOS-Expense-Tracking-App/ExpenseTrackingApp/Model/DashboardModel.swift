//
//  DashboardModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import Foundation

struct CategoryCount: Codable, Hashable {
    let count: Int
}

struct TransactionCount: Codable, Hashable {
    let count: Int
}

struct BudgetTotal: Codable, Hashable {
    let totalBudget: Int
}
