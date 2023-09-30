//
//  CategoryReport.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import SwiftUI
import Charts
import SwiftUICharts

struct CategoryReport: View {
    
    @StateObject var categoryData = ReportsViewModel()
    
    var body: some View {
        VStack {
            if categoryData.isRefreshing {
                ProgressView()
            } else {
                if categoryData.categoryPercentage.isEmpty {
                    VStack {
                        Image(systemName: "tray.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)

                        Text("No Category Records to generate report")
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 100)
                        
                } else {
//                    Chart {
//                        ForEach(categoryData.categoryPercentage, id: \.self) { category in
//
//                        }
//                    }
                    PieChartView(data: [8,23,54,32], title: "Title", legend: "Legendary")
                }
            }
            Spacer()
        }
        .onAppear{
            categoryData.getCategoryDetails()
        }
        .padding()
    }
}

struct CategoryReport_Previews: PreviewProvider {
    static var previews: some View {
        CategoryReport()
    }
}
