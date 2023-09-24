//
//  ExpensesView.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 24/09/2023.
//

import SwiftUI

struct ExpensesView: View {
    
    @ObservedObject private var viewModel = ExpenseViewModel()
    
    var body: some View {
        //        ScrollView(.vertical, showsIndicators: false) {
        //            VStack(spacing: 18) {
        //                HStack {
        //                    VStack(alignment: .leading, spacing: 8) {
        //                        Text("Expenses")
        //                            .font(.title.bold())
        //                    }
        //                    Spacer(minLength: 10)
        //                }
        //            }.padding()
        //
        //        }
        
        NavigationStack {
            List(viewModel.expenses) { expense in
                VStack(alignment: .leading) {
                    Text(expense.expenseTitle)
                        .font(.title)
                    Text(expense.description)
                        .font(.title2)
                }
            }
            .navigationTitle("Expenses")
            .overlay {
                if viewModel.expenses.isEmpty {
                    Label("No expenses", systemImage: "tray.fill")
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .onAppear(){
                self.viewModel.fetchData()
            }
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
