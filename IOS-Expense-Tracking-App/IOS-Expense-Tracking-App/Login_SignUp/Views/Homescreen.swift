//
//  Homescreen.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 16/09/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct Homescreen: View {
    var body: some View {
        VStack{
            Text("Logged successfully")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black.opacity(0.7))
            
            Button(action: {
                try! Auth.auth().signOut()
                UserDefaults.standard.set(false, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }) {
                Text("Log out")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color("Color"))
            .cornerRadius(10)
            .padding(.top, 25)
        }
    }
}

//struct Homescreen_Previews: PreviewProvider {
//    static var previews: some View {
//        Homescreen()
//    }
//}
