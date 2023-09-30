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
    
    @State private var categoryTitle: String = ""
    @ObservedObject private var categoryViewModel = CategoryViewModel()
    
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
                                        Image(systemName: "tag.fill")
                                            .foregroundColor(.blue)
                                        Text(category.categoryTitle)
                                            .font(.headline)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
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
        .sheet(isPresented: $addCategory) {
            categoryTitle = ""
        } content: {
            if categoryData.isRefreshing {
                ProgressView()
            } else {
                NavigationStack {
                    List {
                        Section("Category Name") {
                            TextField("Enter Category Name", text: $categoryTitle)
                        }
                    }
                    .navigationTitle("Category Name")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") {
                                addCategory = false
                            }
                            .tint(.red)
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add") {
                                //let category = Category(categoryTitle: categoryTitle)
                                if (categoryTitle != "") {
                                    categoryData.addCategory(newAddedValue: categoryTitle)
                                }
                                categoryTitle = ""
                                addCategory = false
                            }
                            .disabled(categoryTitle.isEmpty)
                        }
                    }
                }
                .presentationDetents([.height(180)])
                .presentationCornerRadius(20)
                .interactiveDismissDisabled()
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
