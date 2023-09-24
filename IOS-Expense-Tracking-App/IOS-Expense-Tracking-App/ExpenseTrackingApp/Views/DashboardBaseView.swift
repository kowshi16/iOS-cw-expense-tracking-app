//
//  BaseView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 23/09/2023.
//

import SwiftUI

struct DashboardBaseView: View {
    
    @State var currentTab = "home"
    
    // MARK: HIDE NATIVE TAB
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: BOTTOM NAV ITEM
             TabView(selection: $currentTab) {
                 DashboardView()
                     .modifier(BGModifier())
                     .tag("home")
                 Text("Graph")
                     .modifier(BGModifier())
                     .tag("chart")
                 ExpensesView()
                     .modifier(BGModifier())
                     .tag("expense")
                 CategoryView()
                     .modifier(BGModifier())
                     .tag("category")
                 SettingsView()
                     .modifier(BGModifier())
                     .tag("setting")
             } // END NAV ITEM
            
            // MARK: - CUSTOM TAB BAR
            HStack(spacing: 40) {
                // MARK: - TAB BUTTON
                TabButton(image: "home")
                TabButton(image: "chart")
                
                // MARK: - CENTER BUTTON
//                Button {
//                    
//                } label: {
//                    Image(systemName: "plus")
//                        .font(.system(size: 20, weight: .bold))
//                        .foregroundColor(.white)
//                        .padding(22)
//                        .background(
//                            Circle()
//                                .fill(Color("menuTab"))
//                                .shadow(color: Color("menuTab").opacity(0.15), radius: 5, x: 0, y: 8)
//                        )
//                }
//               .offset(y: -20)
//               .padding(.horizontal, -15)
                
                TabButton(image: "expense")
                TabButton(image: "category")
                TabButton(image: "setting")

            }
            .padding(.top, -10)
            .frame(maxWidth: .infinity)
            .background(
                Color.white
                    .ignoresSafeArea()
            )
        }
    }
    @ViewBuilder
    func TabButton(image: String)-> some View {
        Button {
            withAnimation {
                currentTab = image
            }
        } label: {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(
                    currentTab == image ? Color.black : Color.gray.opacity(0.8)
                )
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardBaseView()
    }
}


// MARK: BACKGROUND MODIFIER

struct BGModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white.ignoresSafeArea())
    }
}
