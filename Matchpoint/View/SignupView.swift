//
//  SignupView.swift
//  Matchpoint
//
//  Created by Jacob Parker on 25/6/2026.
//

import SwiftUI

struct SignupView: View {
    @EnvironmentObject var user : MatchpointViewModel
    @State var username: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var showPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            
            Text("Signup")
                .font(.title)
            
            TextField("Username", text: $username, prompt: Text("Username"))
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            TextField("Email", text: $email, prompt: Text("Email"))
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
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

            }
            
            Button{
                user.signup(email: email, username: username, password: password)
            } label: {
                Text("Sign Up")
            }
            .buttonStyle(.borderedProminent)
            .disabled(username.isEmpty || email.isEmpty || password.isEmpty)
            .padding(10)
            .padding(.horizontal)
        
        }
        .alert("", isPresented: $user.showError) {
            Button("Ok") { user.showError.toggle() }
        } message: {
            Text(user.errorMessage)
        }
        .padding(10)
        .padding(.horizontal)
        
    }
}

#Preview {
    SignupView()
        .environmentObject(MatchpointViewModel())
}
