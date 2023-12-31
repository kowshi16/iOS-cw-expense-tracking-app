//
//  DashboardView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 18/09/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct DashboardView: View {
    
    @StateObject var viewModel = DashboardViewModel()

    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 18) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Welcome")
                            .font(.title.bold())
                        
                        Text("Track your income and expenses")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 10)
                    
                    // MARK: - NOTIFICATION
                    Button {
                        
                    } label: {
                        Image(systemName: "bell")
                            .font(.title)
                            .foregroundColor(.gray)
                            .overlay(
                                Text("2")
                                    .font(.caption2.bold())
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .background(Color.pink)
                                    .clipShape(Circle())
                                    .offset(x: 11, y: -12),
                                
                                alignment: .topTrailing
                            )
                            .offset(x: -2)
                            .padding(15)
                            .background(Color("BG"))
                            .clipShape(Circle())
                    } // NOTIFICATION END
                }
                
                HStack(spacing: 0) {
                    OrderProgress(title: "Total Category Count",
                                  color: Color("chartColor2"),
                                  image: "cart.badge.plus",
                                  progress: viewModel.categoryCount ?? 0)
                    
                    OrderProgress(title: "Total Transaction Count", color: Color("roundColor"), image: "clock.badge.checkmark", progress: viewModel.transactionCount ?? 0)
                    
                }
                .padding()
                .background(Color("BG"))
                .cornerRadius(18)
                .padding(.bottom, -25)
                
                GraphView(sales: sales)
                
                VStack {
                    HStack {
                        Text("Savings")
                            .font(.callout.bold())
                        
                        Spacer()
                        
                        Menu {
                            Button("Day"){}
                            Button("Week"){}
                            Button("Month"){}
                            Button("Year"){}
                        } label: {
                            Image("option")
                                .resizable()
                                .renderingMode(.template)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    HStack(spacing: 15) {
                        Image(systemName: "bag.fill")
                            .font(.title2)
                            .foregroundColor(.pink)
                            .padding(12)
                            .background(
                                Color.gray
                                    .opacity(0.25)
                                    .clipShape(Circle())
                            )
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Total Budget for this month")
                                .fontWeight(.bold)
                            if let totalBudget = viewModel.totalBudget {
                                Text("LKR. \(totalBudget)")
                                    .font(.caption2.bold())
                                    .foregroundColor(.gray)
                            } else {
                                Text("LKR. 0")
                                    .font(.caption2.bold())
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        Image(systemName: "cart.fill.badge.plus")
                            .font(.title2)
                            .foregroundColor(Color("chartColor2"))
                    } // END PRODUCT LIST
                    .padding(.top, 10)
                } // END TOP SELL
                .padding()
                .background(Color("BG"))
                .cornerRadius(18)
                
            }.onAppear{
                viewModel.getCategoryCount()
            }
            .onAppear{
                viewModel.getTranactionCount()
            }
            .onAppear{
                viewModel.getTotalBudget()
            }
            .padding()
        }
    }
    
    

    @ViewBuilder
    func OrderProgress(title: String, color: Color, image: String, progress: Int)->some View {
        HStack {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(color)
                .padding(10)
                .background(
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        
                        Circle()
                            .trim(from: 0, to: CGFloat(progress / 100))
                            .stroke(color, lineWidth: 2)
                    }
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(Int(progress))")
                    .font(.title2.bold())
                
                Text(title)
                    .font(.caption2.bold())
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
