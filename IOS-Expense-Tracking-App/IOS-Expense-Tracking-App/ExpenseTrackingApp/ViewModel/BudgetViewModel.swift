//
//  BudgetViewModel.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import Foundation

class BudgetViewModel: ObservableObject {
    
    @Published var budget: [Budget] = []
    @Published var hasError = false
    @Published var error: BudgetError?
    @Published private(set) var isRefreshing = false
    @Published var response = ""
    
    func addBudget(budgetTitle: String, amount: Int, category: Category, budgetType: String) {
        self.isRefreshing = true
        self.hasError = false
        
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/budget/create") else {
            return
        }
        
        print("Making API Call For Budget.......")
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.timeoutInterval = 20
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: AnyHashable] = [
            "budgetTitle": budgetTitle,
            "amount": amount,
            "category": category._id,
            "budgetType": budgetType
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
                    self.error = BudgetError.custom(error: error)
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
    
    func deleteBudget(budgetId: String) {
        self.isRefreshing = true
        self.hasError = false
        
        guard let url = URL(string: "https://expense-tracking-j7tf.onrender.com/budget/delete/\(budgetId)") else {
                    print("Error: cannot create URL")
                    return
                }
        
        var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else {
                        print("Error: error calling DELETE")
                        print(error!)
                        return
                    }
                    guard let data = data else {
                        print("Error: Did not receive data")
                        return
                    }
                    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                        print("Error: HTTP request failed")
                        return
                    }
                    do {
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                            print("Error: Cannot convert data to JSON")
                            return
                        }
                        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                            print("Error: Cannot convert JSON object to Pretty JSON data")
                            return
                        }
                        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                            print("Error: Could print JSON in String")
                            return
                        }
                        
                        print(prettyPrintedJson)
                    } catch {
                        print("Error: Trying to convert JSON data to string")
                        return
                    }
                }.resume()
    }
}

extension BudgetViewModel {
    enum BudgetError: LocalizedError {
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
