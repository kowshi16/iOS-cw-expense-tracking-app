//
//  ExpenseModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 24/09/2023.
//

import Foundation

struct Expense: Identifiable {
    var id: String = UUID().uuidString
    var expenseTitle: String
    var description: String
    var category: Category
    var expenseDate: Date
}
