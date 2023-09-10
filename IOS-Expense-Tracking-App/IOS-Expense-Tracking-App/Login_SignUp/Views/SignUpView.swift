//
//  SignUp.swift
//  IOS-Expense-Tracking-App
//
//  Created by air on 10/09/2023.
//

import SwiftUI

struct SignUpView: View {
    @State var color = Color.black.opacity(0.7)
    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var visible = false
    @State var confirmPasswordVisible = false
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading){
            GeometryReader{_ in
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Log into your account")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(self.color)
                        .padding(.top, 35)
                    
                    TextField("Email", text: self.$email)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("Color") : self.color, lineWidth: 2))
                        .padding(.top, 25)
                    
                    HStack(spacing: 15){
                        VStack {
                            if self.visible{
                                TextField("Password", text: self.$password)
                            }
                            else{
                                SecureField("Password", text: self.$password)
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
                            }
                            else{
                                SecureField("Confirm Password", text: self.$confirmPassword)
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
            
            Button(action: {
                
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(Color("Color"))
            }
            .padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
