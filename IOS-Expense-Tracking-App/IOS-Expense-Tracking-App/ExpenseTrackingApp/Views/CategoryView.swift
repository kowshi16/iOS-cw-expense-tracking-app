//
//  CategoryView.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 24/09/2023.
//

import SwiftUI

struct CategoryView: View {
    
    
    @StateObject var categoryData = CategoryViewModel()
    
    @State private var addCategory: Bool = false
    @State private var showAlert = false
    @State private var deleteRequest: Bool = false
    @State private var isSwipeGestureActive = false
    
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 18) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Category")
                                .font(.title.bold())
                        }
                        Spacer(minLength: 10)
                        
                        Button {
                            addCategory.toggle()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title3)
                        }
                    }
                    
                    VStack {
                        if categoryData.isRefreshing {
                            ProgressView()
                        } else {
                            if (categoryData.categories.isEmpty) {
                                VStack {
                                    Image(systemName: "tray.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                    
                                    Text("No Category Records")
                                        .font(.title2)
                                        .multilineTextAlignment(.center)
                                }.padding(.top, 100)
                            } else {
                                ForEach(categoryData.categories, id: \.self) { category in
                                    HStack {
                                        Image(systemName: "building.columns").foregroundColor(.blue)
                                        Text(category.categoryTitle).font(.headline)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .padding(.horizontal, 4)
                                }
                            }
                                
                        }
                    }
                    .onAppear{
                        categoryData.fetchCategoryData()
                    }
                }.padding()
            })
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
