//
//  SettingsView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 23/09/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct SettingsView: View {
    
    @State private var userEmail: String?
    
    var body: some View {
        VStack{
            NavigationView{
                Form {
                    HStack {
                        Image(systemName: "person.crop.circle").resizable()
                            .frame(width: 50, height: 50).foregroundColor(.blue)
                        VStack(alignment: .leading){
                            if let email = userEmail {
                                Text(email).font(.title2)
                            }
                        }.onAppear {
                            fetchUserEmail()
                        }
                    }
                    
                    Section {
                        HStack{
                            ZStack{
                                RoundedRectangle(cornerRadius: 4).fill(.red)
                                    .frame(width: 28, height: 28)
                                Image(systemName:"person.crop.circle.badge.xmark").foregroundColor(.white)
                            }
                            VStack(alignment: .leading){
                                Text("Logout")
                            }
                        }
                    }.onTapGesture {
                        try! Auth.auth().signOut()
                        UserDefaults.standard.set(false, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    }
                }
                .navigationTitle("Settings")
            }
        }
    }
    
    private func fetchUserEmail() {
            if let user = Auth.auth().currentUser {
                self.userEmail = user.email
            }
        }
}



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
