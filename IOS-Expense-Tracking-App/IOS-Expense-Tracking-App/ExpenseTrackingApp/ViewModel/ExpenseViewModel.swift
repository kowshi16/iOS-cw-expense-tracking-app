//
//  ExpenseViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 24/09/2023.
//

import Foundation
import FirebaseFirestore

class ExpenseViewModel: ObservableObject {
    @Published var expenses = [Expense]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("expense").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.expenses = documents.map{ (queryDocumentSnapshot) -> Expense in
                let data = queryDocumentSnapshot.data()
                
                let expenseTitle = data["expenseTitle"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let category = data["category"] as? Category ?? Category(categoryTitle: "Default Category")
                let expenseDate = data["expenseDate"] as? Date ?? Date()
                
                return Expense(expenseTitle: expenseTitle, description: description, category: category , expenseDate: expenseDate)
            }
        }
    }
}
