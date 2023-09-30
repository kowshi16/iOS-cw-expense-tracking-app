//
//  AddBudgetView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import SwiftUI

struct AddBudgetView: View {
    
    @State private var budgetTitle: String = ""
    private let budgetType = ["Today", "This Week", "This Month"]
    @State private var selectedOption = 0
    @State private var amount: CGFloat = 0
    @State private var category: Category?
    @StateObject var allCategories = CategoryViewModel()
    @StateObject var budgetVM = BudgetViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("Enter the Title", text: $budgetTitle)
                }
                
                Section("Budget Period") {
                    if !budgetType.isEmpty {
                        HStack {
                            Text("Select the Time Period")
                            Spacer()
                            Picker("", selection: $selectedOption) {
                                ForEach(0..<budgetType.count, id: \.self) { index in
                                    Text(budgetType[index])
                                }
                            }
                            .pickerStyle(.menu)
                            .labelsHidden()
                        }
                    }
                }
                
                Section("Amount") {
                    HStack(spacing: 4) {
                        Text("LKR")
                            .fontWeight(.semibold)
                    }
                    TextField("0.0", value: $amount, formatter: formatter)
                        .keyboardType(.numberPad)
                }
                
                // Category Picker
                Section("Category") {
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
                                Button("None") {
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
                    } else {
                        HStack {
                            Text("Select the Category")
                            Spacer()
                            Menu {
                                
                            } label: {
                                ProgressView()
                            }
                        }
                    }
                }
            }
            .onAppear{
                allCategories.fetchCategoryData()
            }
            .navigationTitle("Add Budget")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                // Cancel and Add Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        
                        let budgetType = selectedOption == 0 ? "Today" : selectedOption == 1 ? "This Week" : "This Month"
                        
                        
                        budgetVM.addBudget(budgetTitle: budgetTitle, amount: Int(amount), category: category!, budgetType: budgetType)
                        
                        dismiss()
                        
                    }
                    .disabled(isAddButtonDisabled)
                }
            }
        }
    }
    
    // Disabling Add Button untill all data is entered
    var isAddButtonDisabled: Bool {
        return budgetTitle.isEmpty || category == nil || amount == .zero
    }
    
    // Decimal Formatter
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
}

struct AddBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        AddBudgetView()
    }
}
