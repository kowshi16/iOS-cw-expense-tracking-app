//
//  CategoryViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 24/09/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Category: Codable, Hashable {
    let _id: String
    let categoryTitle: String
}
