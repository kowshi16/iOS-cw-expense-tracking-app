//
//  CategoryEditView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 26/09/2023.
//

import SwiftUI

struct CategoryEditView: View {
    
    @StateObject var viewModel = CategoryAddViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Category")) {
//                    TextField("Title", text: $viewModel.category.categoryTitle)
                }
            }
            .navigationBarTitle("New Category", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: { handleCancelTapped() }, label: {
                    Text("Cancel")
                }),
                trailing: Button(action: { handleDoneTapped()}, label: {
                    Text("Done")
                })
                .disabled(!viewModel.modified)
            )
        }
    }
    
    func handleCancelTapped() {
        dismiss()
    }

    func handleDoneTapped() {
        viewModel.save()
        dismiss()
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct CategoryEditView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryEditView()
    }
}
