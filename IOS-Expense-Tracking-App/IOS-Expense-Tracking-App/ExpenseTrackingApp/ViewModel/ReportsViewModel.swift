//
//  ReportsViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import Foundation

class ReportsViewModel: ObservableObject {
    @Published var expenses: [TransactionReport] = []
    @Published var income: [TransactionReport] = []
    @Published var categoryPercentage: [CategoryPercentageReport] = []
    @Published var hasError = false
    @Published var error: ReportsError?
    @Published private(set) var isRefreshing = false
    
    func getExpenseDetails(fromDate: String, toDate: String, category: Category){
        
        self.isRefreshing = true
        
        print("fromDate >>>>>>", fromDate)
        print("toDate >>>>>>", toDate)
        print("category >>>>>>", category)
        
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/report/get-transaction?fromDate=\(fromDate)&toDate=\(toDate)&category=\(category._id)&type=Expense") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.global().async {
                if let error = error {
                    self.hasError = true
                    self.error = ReportsError.custom(error: error)
                }
                
                do {
                    let expenses = try JSONDecoder().decode([TransactionReport].self, from: data)
                    DispatchQueue.main.async {
                        self.expenses = expenses
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
    
    func getIncomeDetails(fromDate: String, toDate: String, category: Category){
        
        self.isRefreshing = true
        
        print("fromDate >>>>>>", fromDate)
        print("toDate >>>>>>", toDate)
        print("category >>>>>>", category)
        
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/report/get-transaction?fromDate=\(fromDate)&toDate=\(toDate)&category=\(category._id)&type=Income") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.global().async {
                if let error = error {
                    self.hasError = true
                    self.error = ReportsError.custom(error: error)
                }
                
                do {
                    let income = try JSONDecoder().decode([TransactionReport].self, from: data)
                    DispatchQueue.main.async {
                        self.income = income
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
    
    func getCategoryDetails(){
        
        self.isRefreshing = true
        
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/report/get-category") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.global().async {
                if let error = error {
                    self.hasError = true
                    self.error = ReportsError.custom(error: error)
                }
                
                do {
                    let categoryPercentage = try JSONDecoder().decode([CategoryPercentageReport].self, from: data)
                    DispatchQueue.main.async {
                        self.categoryPercentage = categoryPercentage
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
}

extension ReportsViewModel {
    enum ReportsError: LocalizedError {
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
