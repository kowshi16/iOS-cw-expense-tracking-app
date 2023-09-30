//
//  ExpenseReport.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import SwiftUI
import Charts

struct ExpenseReport: View {
    @StateObject var expenseData = ReportsViewModel()
    @State private var startDate = Date()
    @State private var endDate = Date()
    @StateObject var allCategories = CategoryViewModel()
    @State private var category: Category?
    
    var body: some View {
        VStack {
            
            DatePicker(selection: $startDate, in: ...Date(), displayedComponents: .date) {
                Text("Start Date")
            }
            
            DatePicker(selection: $endDate, in: ...Date(), displayedComponents: .date) {
                Text("End Date")
            }
            
            if !allCategories.categories.isEmpty {
                HStack {
                    Text("Select the Category")
                    Spacer()
                    Menu {
                        ForEach(allCategories.categories, id: \.self) { category in
                            Button(category.categoryTitle) {
                                self.category = category
                            }
                        }
                        
                        Button("All") {
                            category = nil
                        }
                    } label: {
                        if let categoryName = category?.categoryTitle {
                            Text(categoryName)
                        } else {
                            Text("None")
                        }
                    }
                }
            }
            
            Button("Search") {
                let selectedCategory = Category(_id: "", categoryTitle: "")
                
                expenseData.getExpenseDetails(fromDate: startDate.ISO8601Format(), toDate: endDate.ISO8601Format(), category: category ?? selectedCategory)
            }
            .buttonStyle(.borderedProminent)
            
            if expenseData.isRefreshing {
                ProgressView()
            } else {
                if expenseData.expenses.isEmpty {
                    VStack {
                        Image(systemName: "tray.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        Text("No Expense Records to generate report")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 100)
                } else {
                    Chart {
                        ForEach(expenseData.expenses, id: \.self) { expense in
                            BarMark(x: .value("Category", expense.category.categoryTitle), y: .value("Amount", expense.amount))
                                .annotation(position: .overlay) {
                                    
                                }
                        }
                    }
                }
            }
            Spacer()
        }
        .onAppear{
            allCategories.fetchCategoryData()
        }
        .padding()
    }
    
}

struct ExpenseReport_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseReport()
    }
}
