//
//  BaseView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 23/09/2023.
//

import SwiftUI

struct DashboardBaseView: View {
    
    var body: some View {
        TabView {
            DashboardView()
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            CategoryView()
                .tabItem{
                    Image(systemName: "square.grid.3x3")
                    Text("Category")
                }
            
            ExpensesView()
                .tabItem{
                    Image(systemName: "dollarsign.circle.fill")
                    Text("Transactions")
                }
            
            ReportView()
                .tabItem{
                    Image(systemName: "chart.bar")
                    Text("Reports")
                }
            
            SettingsView()
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
    
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardBaseView()
    }
}
