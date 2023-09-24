//
//  CategoryView.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 24/09/2023.
//

import SwiftUI

struct CategoryView: View {
    
    @ObservedObject private var viewModel = CategoryViewModel()
    
    var body: some View {
//        ScrollView(.vertical, showsIndicators: false) {
//            VStack(spacing: 18) {
//                HStack {
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("Category")
//                            .font(.title.bold())
//                    }
//                    Spacer(minLength: 10)
//                }
//            }.padding()
//        }
        
//        NavigationView{
//            List(viewModel.categories) { category in
//                VStack(alignment: .leading) {
//                    Text(category.categoryTitle)
//                        .font(.headline)
//                }
//            }
//        }
//        .navigationTitle("Category")
//        .onAppear(){
//            self.viewModel.fetchData()
//        }
        
        NavigationStack {
            List(viewModel.categories) { category in
                VStack(alignment: .leading) {
                    Text(category.categoryTitle)
                        .font(.headline)
                }
            }
            .navigationTitle("Category")
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

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
