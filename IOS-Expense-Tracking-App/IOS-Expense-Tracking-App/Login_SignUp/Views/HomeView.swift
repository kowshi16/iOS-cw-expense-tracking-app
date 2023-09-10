//
//  HomeView.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 10/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State var show = false
    
    var body: some View {
//        NavigationView{
//           ZStack {
//               NavigationLink(destination: SignUpView(show: self.$show), isActive: self.$show){
//                   Text("")
//               }
//               .hidden()
//
//               LoginView(show: self.$show)
//            }
//        }
        NavigationStack{
            NavigationLink("Place Order") {
                SignUpView(show: self.$show)
            }
                           .hidden()
            
            LoginView(show: self.$show)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
