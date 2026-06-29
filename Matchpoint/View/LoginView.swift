//
//  LoginView.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var user : MatchpointViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Login")
                .font(.title)
            HStack {
                Text("New to Matchpoint?")
                NavigationLink("Sign up") {
                    SignupView()
                }
            }
            
            TextField("Email", text: $email, prompt: Text("Email"))
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
                .padding(10)
                .padding(.horizontal)
            
            HStack {
                Group {
                    if showPassword {
                        TextField("Password", text: $password, prompt: Text("Password"))
                            .textFieldStyle(.roundedBorder)
                            .frame(alignment: .center)
                    } else {
                        SecureField("Password", text: $password, prompt: Text("Password"))
                            .textFieldStyle(.roundedBorder)
                            .frame(alignment: .center)
                    }
                }
                .overlay(alignment: .trailing) {
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                        .padding(.trailing)
                    }
                }
                .padding(.horizontal)
                .padding(10)
                
            }
            
            Button{
                user.login(email: email, password: password)
            } label: {
                Text("Login")
            }
            .buttonStyle(.borderedProminent)
            .disabled(email.isEmpty || password.isEmpty)
            .padding(20)
            .padding(.horizontal)
            
        }.alert("", isPresented: $user.showError) {
            Button("Ok") { user.showError.toggle() }
        } message: {
            Text(user.errorMessage)
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(MatchpointViewModel())
}
