//
//  ReportView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 30/09/2023.
//

import SwiftUI
import Charts

struct ReportView: View {
    
    @State private var graphType: GraphType = .category
    
    var body: some View {
        NavigationView {
            VStack(spacing: 18) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Reports")
                            .font(.title.bold())
                    }
                    Spacer(minLength: 10)
                }
                
                VStack {
                    Picker("", selection: $graphType) {
                        ForEach(GraphType.allCases, id: \.rawValue) { type in
                            Text(type.rawValue)
                                .tag(type)
                        }
                    }
                    .pickerStyle(.segmented)
                    .labelsHidden()
                    
                    // Charts
                    
                    
                    Spacer(minLength: 0)
                }
                .padding()
                
            }.padding()
            
            
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
