//
//  LoginView.swift
//  IOS-Expense-Tracking-App
//
//  Created by Kowshi on 10/09/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct LoginView: View {
    
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var visible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        ZStack{
            ZStack(alignment: .topTrailing){
                GeometryReader{_ in
                    VStack {
                        Image("LoginLogo")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Log into your account")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 35)
                        
                        TextField("Email", text: self.$email)
                            .autocapitalization(.none)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                            .padding(.top, 25)
                        
                        HStack(spacing: 15){
                            VStack {
                                if self.visible{
                                    TextField("Password", text: self.$password)
                                        .autocapitalization(.none)
                                }
                                else{
                                    SecureField("Password", text: self.$password)
                                        .autocapitalization(.none)
                                }
                            }
                            Button(action: {
                                self.visible.toggle()
                            }) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack{
                            HStack{
                                Button(action: {
                                    show.toggle()
                                }) {
                                    Text("Sign Up")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Color"))
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    self.reset()
                                }) {
                                    Text("Forgot Password")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("Color"))
                                }
                            }
                            
                        }
                        .padding(.top, 20)
                        
                        Button(action: {
                            self.verify()
                        }) {
                            Text("Login")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("Color"))
                        .cornerRadius(10)
                        .padding(.top, 25)
                    }
                    .padding(.horizontal, 15)
                }
            }
            
            if (self.alert){
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
    }
    
    func verify(){
        if self.email != "" && self.password != ""{
            Auth.auth().signIn(withEmail: self.email, password: self.password){ (res,err) in
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                print("success")
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else {
            self.error = "Please fill out all the details"
            self.alert.toggle()
        }
    }
    
    func reset(){
        if self.email != "" {
            Auth.auth().sendPasswordReset(withEmail: self.email){ (err) in
                if err != nil{
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "RESET"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Email is empty"
            self.alert.toggle()
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
