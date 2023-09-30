//
//  ExpenseViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 24/09/2023.
//

import Foundation
import FirebaseFirestore
import Combine

class ExpenseViewModel: ObservableObject {
    @Published var transactions: [Expense] = []
    @Published var hasError = false
    @Published var error: ExpenseError?
    @Published private(set) var isRefreshing = false
    
    func fetchTransData() {
        self.isRefreshing = true
        
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/transaction/get-all") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.global().async {
                if let error = error {
                    self.hasError = true
                    self.error = ExpenseError.custom(error: error)
                }
                
                do {
                    let transactions = try JSONDecoder().decode([Expense].self, from: data)
                    DispatchQueue.main.async {
                        self.transactions = transactions
                    }
                    
                }
                catch {
                    print(error)
//                    self.hasError = true
//                    self.error = ExpenseError.failedToDecode
                }
                
                DispatchQueue.main.async {
                    self.isRefreshing = false
                }
            }
            
        }
        
        task.resume()
        
    }
    
    func addTransaction(transTitle: String, description: String, amount: Int, transType: String, category: Category, location: String, transDate: String) {
        self.isRefreshing = true
        self.hasError = false
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/transaction/create") else {
            return
        }
        
        print("Making API Call For Transaction.......")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "transTitle": transTitle,
            "description": description,
            "amount": amount,
            "transType": transType,
            "category": category._id,
            "location": location,
            "transDate": transDate
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        // Make the request
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.global().async {
                if let error = error {
                    self.hasError = true
                    self.error = ExpenseError.custom(error: error)
                }
                
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    print("SUCCESS", response)
                    self.isRefreshing = true
                }
                catch {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self.isRefreshing = false
                }
            }
            
           
        }
        task.resume()
    }

}

extension ExpenseViewModel {
    enum ExpenseError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case.failedToDecode:
                return "Failed to load data"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
