//
//  CategoryViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 24/09/2023.
//

import Foundation

struct Category: Identifiable {
    var id: String = UUID().uuidString
    var categoryTitle: String
}
