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
        
//        NavigationStack {
//            List(viewModel.expenses) { expense in
//                VStack(alignment: .leading) {
//                    Text(expense.expenseTitle)
//                        .font(.title)
//                    Text(expense.description)
//                        .font(.title2)
//                }
//            }
//            .navigationTitle("Expenses")
//            .overlay {
//                if viewModel.expenses.isEmpty {
//                    Label("No expenses", systemImage: "tray.fill")
//                }
//            }
//            .toolbar{
//                ToolbarItem(placement: .navigationBarTrailing){
//                    Button {
//
//                    } label: {
//                        Image(systemName: "plus.circle.fill")
//                            .font(.title3)
//                    }
//                }
//            }
//            .onAppear(){
//                self.viewModel.fetchData()
//            }
//        }
        
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
        
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
