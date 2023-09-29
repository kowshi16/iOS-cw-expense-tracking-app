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
    @Published var expenses = [Expense]()
    @Published var searchQuery = ""
    
    var searchCancellable: AnyCancellable? = nil
    
    init() {
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    
                }
                else {
                    print(str)
                }
                
            })
    }

}
