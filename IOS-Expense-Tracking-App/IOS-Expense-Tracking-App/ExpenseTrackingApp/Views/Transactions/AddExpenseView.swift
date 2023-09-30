//
//  AddExpenseView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.dismiss) private var dismiss
    private let options = ["Income", "Expense"]
    
    @State private var expenseTitle: String = ""
    @State private var description: String = ""
    @State private var transDate: Date = .init()
    @State private var amount: CGFloat = 0
    @State private var category: Category?
    @State private var location: String = ""
    @State private var transType: String = ""
    
    @State private var selectedOption = 0
    @StateObject var allCategories = CategoryViewModel()
    @StateObject var transData = ExpenseViewModel()
    @State private var selectedCategory: Category?
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("Enter the Title", text: $expenseTitle)
                }
                
                Section("Description") {
                    TextField("Enter the Description", text: $description)
                }
                
                Section("Amount") {
                    HStack(spacing: 4) {
                        Text("LKR")
                            .fontWeight(.semibold)
                    }
                    TextField("0.0", value: $amount, formatter: formatter)
                        .keyboardType(.numberPad)
                }
                
                Section("Type") {
                    if !options.isEmpty {
                        HStack {
                            Text("Select the Type")
                            Spacer()
                            Picker("", selection: $selectedOption) {
                                ForEach(0..<options.count, id: \.self) { index in
                                    Text(options[index])
                                }
                            }
                            .pickerStyle(.menu)
                            .labelsHidden()
                        }
                    }
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
                            //                            Picker("", selection: $selectedCategory) {
                            //                                ForEach(allCategories.categories, id: \.self) { category in
                            //                                    Text(category.categoryTitle).tag(category)
                            //                                }
                            //                            }
                            //                            .pickerStyle(.menu)
                            //                            .labelsHidden()
                        }
                    }
                }
                
                Section("Location") {
                    TextField("Enter the Location", text: $location)
                }
                
                Section("Date") {
                    DatePicker(selection: $transDate, in: ...Date(), displayedComponents: .date) {
                        Text("Select a date")
                    }
                    //                    DatePicker("", selection: $transDate, displayedComponents: [.date])
                    //                        .datePickerStyle(.graphical)
                    //                        .labelsHidden()
                }
                
            }
            .onAppear{
                allCategories.fetchCategoryData()
            }
            .navigationTitle("Add Expense")
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
                        
                        let transType = selectedOption == 0 ? "Income" : "Expense"
                        
                        transData.addTransaction(transTitle: expenseTitle, description: description, amount: Int(amount), transType: transType, category: category!, location: location, transDate: transDate.ISO8601Format())
                        
                        dismiss()
                    }
                    .disabled(isAddButtonDisabled)
                }
            }
        }
    }
    
    // Disabling Add Button untill all data is entered
    var isAddButtonDisabled: Bool {
        return expenseTitle.isEmpty || description.isEmpty || amount == .zero || category == nil
    }
    
    
    // Decimal Formatter
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
