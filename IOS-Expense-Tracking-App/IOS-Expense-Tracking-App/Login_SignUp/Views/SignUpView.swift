//
//  SignUp.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 10/09/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct SignUpView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var visible = false
    @State var confirmPasswordVisible = false
    @Binding var show: Bool
    @State var alert = false
    @State var error = ""
    
    var body: some View {
        ZStack{
            ZStack(){
                GeometryReader{_ in
                    VStack {
                        Image("SignupLogo")
                            .resizable()
                            .scaledToFit()
                        
                        Text("Create an account")
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
                        
                        HStack(spacing: 15){
                            VStack {
                                if self.confirmPasswordVisible{
                                    TextField("Confirm Password", text: self.$confirmPassword)
                                        .autocapitalization(.none)
                                }
                                else{
                                    SecureField("Confirm Password", text: self.$confirmPassword)
                                        .autocapitalization(.none)
                                }
                            }
                            Button(action: {
                                self.confirmPasswordVisible.toggle()
                            }) {
                                Image(systemName: self.confirmPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.confirmPassword != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                        
                        Button(action: {
                            self.register()
                        }) {
                            Text("Sign In")
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
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        
    }
    
    func register(){
        if self.email != "" {
            if self.password == self.confirmPassword{
                Auth.auth().createUser(withEmail: self.email, password: self.password){
                    (res, err) in
                    
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
            else{
                self.error = "Password Mismatch"
                self.alert.toggle()
            }
        }
        else{
            self.error = "Please fill out all the details"
            self.alert.toggle()
        }
    }
}

//
//struct SignUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignUpView()
//    }
//}
