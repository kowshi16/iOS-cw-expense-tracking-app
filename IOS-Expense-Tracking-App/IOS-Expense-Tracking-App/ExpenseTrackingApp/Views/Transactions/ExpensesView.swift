//
//  ExpensesView.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 24/09/2023.
//

import SwiftUI

struct ExpensesView: View {
    
    @ObservedObject private var viewModel = ExpenseViewModel()
    @State private var addExpense: Bool = false
    @StateObject var expenseData = ExpenseViewModel()
    @State private var addBudget: Bool = false
    
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
                        
                        Button("Add Budget") {
                            addBudget.toggle()
                        }.buttonStyle(.borderedProminent)
                        
                        Button {
                            addExpense.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                        }
                    }
                    
                    VStack {
                        if expenseData.isRefreshing {
                            ProgressView()
                        } else {
                            if (expenseData.transactions.isEmpty) {
                                VStack {
                                    Image(systemName: "tray.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                    
                                    Text("No Transaction Records")
                                        .font(.title2)
                                        .multilineTextAlignment(.center)
                                }.padding(.top, 100)
                            } else {
                                ForEach(expenseData.transactions, id: \.self) { transaction in
                                    HStack(spacing: 15) {
                                        Image(transaction.transType == "Income" ? "Income" : "Expense")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                        
                                        VStack(alignment: .leading, spacing: 10) {
                                            Text(transaction.transTitle)
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                            
                                            Text(transaction.description)
                                                .font(.headline)
                                                .foregroundColor(.gray)
                                                .fontWeight(.semibold)
                                            
                                            Text(transaction.location)
                                                .fontWeight(.semibold)
                                            
                                            Text(transaction.transDate.split(separator: "T").first ?? "")
                                                .foregroundColor(.gray)
                                                .fontWeight(.semibold)
                                            
                                            Text("LKR. \(transaction.amount)")
                                                .fontWeight(.semibold)
                                            
                                            
                                            HStack {
                                                Capsule()
                                                    .fill(Color.blue)
                                                    .frame(height: 30)
                                                    .overlay(Text(transaction.category.categoryTitle).bold().foregroundColor(Color.white))
                                                
                                                Capsule()
                                                    .fill(transaction.transType == "Income" ? Color.green : Color.red)
                                                    .frame(height: 30)
                                                    .overlay(Text(transaction.transType).bold().foregroundColor(Color.white))
                                            }
                                        }
                                        
                                        HStack {
                                            Button {
                                                //addExpense.toggle()
                                            } label: {
                                                Image(systemName: "trash.fill").foregroundColor(Color.red)
                                            }
                                        }
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .padding(.horizontal, 4)
                                    
                                    
                                    
                                }
                            }
                            
                        }
                    }.onAppear{
                        expenseData.fetchTransData()
                    }
                }.padding()
                
            })
        }
        .sheet(isPresented: $addExpense) {
            AddExpenseView()
                .interactiveDismissDisabled()
        }
        .sheet(isPresented: $addBudget) {
            AddBudgetView()
                .interactiveDismissDisabled()
        }
    }
    
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
