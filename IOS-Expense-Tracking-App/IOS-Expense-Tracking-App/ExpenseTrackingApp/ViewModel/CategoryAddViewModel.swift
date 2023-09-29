//
//  CategoryAddViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 26/09/2023.
//

import Foundation
import FirebaseFirestore
import Combine

class CategoryAddViewModel: ObservableObject {
    
    @Published var category: Category
    @Published var modified = false
    
    private var db = Firestore.firestore()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(category: Category = Category(_id: "", categoryTitle: "")) {
        self.category = category
        
        self.$category
            .dropFirst()
            .sink{ [weak self] category in
                self?.modified = true
            }
            .store(in: &cancellables)
    }
    
    func addCategory(category: Category) {
        do {
            let _ = try db.collection("category").addDocument(from: category)
        }
        catch {
            print(error)
        }
    }
    
    func save() {
        addCategory(category: category)
    }
    
}
