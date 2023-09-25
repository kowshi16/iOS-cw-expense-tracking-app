//
//  CategoryViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 24/09/2023.
//

import Foundation
import FirebaseFirestoreSwift

struct Category: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var categoryTitle: String
    
    enum CodingKeys: String, CodingKey {
        case categoryTitle
    }
}
