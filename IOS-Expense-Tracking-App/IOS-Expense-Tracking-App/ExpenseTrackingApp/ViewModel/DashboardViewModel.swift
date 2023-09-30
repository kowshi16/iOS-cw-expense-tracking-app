//
//  DashboardViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import Foundation

class DashboardViewModel: ObservableObject {
    @Published var categoryCount: Int?
    @Published var transactionCount: Int?
    @Published var totalBudget: Int?
    
    func getCategoryCount(){
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/report/categories/count") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.global().async {
                do {
                    let countResponse = try JSONDecoder().decode(CategoryCount.self, from: data)
                    DispatchQueue.main.async {
                        self.categoryCount = countResponse.count
                    }
                }
                catch {
                    print(error)
                }
            }
            
        }
        
        task.resume()
        
    }
    
    func getTranactionCount(){
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/report/transactions/count") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.global().async {
                do {
                    let countResponse = try JSONDecoder().decode(TransactionCount.self, from: data)
                    DispatchQueue.main.async {
                        self.transactionCount = countResponse.count
                    }
                }
                catch {
                    print(error)
                }
            }
            
        }
        
        task.resume()
        
    }
    
    func getTotalBudget(){
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/report/budget/this-month") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.global().async {
                do {
                    let countResponse = try JSONDecoder().decode(BudgetTotal.self, from: data)
                    DispatchQueue.main.async {
                        self.totalBudget = countResponse.totalBudget
                    }
                }
                catch {
                    print(error)
                }
            }
            
        }
        
        task.resume()
        
    }
}
