//
//  HomeView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 10/09/2023.
//

import SwiftUI

struct HomeView: View {
    
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        NavigationView{
            VStack{
                if self.status{
                    //Homescreen()
                    DashboardBaseView()
                }
                else{
                    ZStack{
                        NavigationLink(destination: SignUpView(show: self.$show), isActive: self.$show){
                                           Text("")
                                       }
                                       .hidden()
                       
                                       LoginView(show: self.$show)
                    }
                }
            }
            
            .navigationBarHidden(true)
            .onAppear{
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main){ (_) in
                    self.status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
