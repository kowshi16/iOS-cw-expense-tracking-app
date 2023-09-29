//
//  ExpensesView.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 24/09/2023.
//

import SwiftUI

struct ExpensesView: View {
    
    @ObservedObject private var viewModel = ExpenseViewModel()
    @StateObject var expenseData = ExpenseViewModel()
    @State private var addExpense: Bool = false
    @StateObject var categoryData = CategoryViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                
                VStack(spacing: 18) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Transactions")
                                .font(.title.bold())
                        }
                        Spacer(minLength: 10)
                        
                        Button {
                            addExpense.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                        }
                        
                        
                    }
                }.padding()
                
                
                VStack(spacing: 15) {
                    
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search Transaction", text: $expenseData.searchQuery)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()
            })
        }
        .sheet(isPresented: $addExpense) {
            AddExpenseView()
                .interactiveDismissDisabled()
        }
    }
    
    // Creating Grouped Transactions (Group By Date)
    func createGroupedTransactions(_ transactions: [Expense]) {
        Task.detached(priority: .high) {
            let groupedDict = Dictionary(grouping: transactions) { expense in
                let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: expense.transDate)
                
                return dateComponents
            }
            
            // Sorting Dictionary in Descending Order
            let sortedDict = groupedDict.sorted {
                let calendar = Calendar.current
                let date1 = calendar.date(from: $0.key) ?? .init()
                let date2 = calendar.date(from: $1.key) ?? .init()
                
                return calendar.compare(date1, to: date2, toGranularity: .day) == .orderedDescending
            }
            
            // Adding to the 
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
