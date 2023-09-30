//
//  ReportView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import SwiftUI

struct ReportView: View {
    @State private var graphType: GraphType = .income
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Reports")
                        .font(.title.bold())
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                    
                    Spacer()
                }
                
                Picker("", selection: $graphType) {
                    ForEach(GraphType.allCases, id: \.rawValue) { type in
                        Text(type.rawValue)
                            .tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .labelsHidden()
                .padding(.horizontal)
                
                Spacer()
                
                Group {
                    if graphType == .category {
                        CategoryReport()
                    } else if graphType == .expense {
                        ExpenseReport()
                    } else if graphType == .income {
                        IncomeReport()
                    } else if graphType == .savings {
                        SavingsReport()
                    }
                }
                .padding()
            }
            .navigationBarTitle("", displayMode: .inline)
            .padding()
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
