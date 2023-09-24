//
//  CategoryViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 24/09/2023.
//

import Foundation
import FirebaseFirestore

class CategoryViewModel: ObservableObject {
    @Published var categories = [Category]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("category").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.categories = documents.map{ (queryDocumentSnapshot) -> Category in
                let data = queryDocumentSnapshot.data()
                
                let categoryTitle = data["categoryTitle"] as? String ?? ""
                
                return Category(categoryTitle: categoryTitle)
            }
        }
    }
}
