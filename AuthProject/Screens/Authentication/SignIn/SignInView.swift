//
//  SignInView.swift
//  Modular
//
//  Created by Max Ward on 29/10/2023.
//

import SwiftUI

struct SignInView: View {
    
    enum Field {
        case None
        case email
        case password
    }
    @FocusState private var focusedField: Field?
    
    var model: AuthUser
    
    @Binding var email: String
    @Binding var password: String
    var emailErrorMessage: String
    var passwordErrorMessage: String
    var disableButtons: Bool
    var action: () -> Void
    
    init(email: Binding<String>, password: Binding<String>,
         emailErrorMessage: String, passwordErrorMessage: String,
         disableButtons: Bool, model: AuthUser, action: @escaping () -> Void) {
        self._email = email
        self._password = password
        self.emailErrorMessage = emailErrorMessage
        self.passwordErrorMessage = passwordErrorMessage
        self.disableButtons = disableButtons
        self.model = model
        self.action = action
    }
    
    var body: some View {
        VStack (spacing: 8) {
            VStack {
                ZBRTextField(text: $email,
                             title: "Enter you email",
                             placeholder: "Email",
                             errorMessage: emailErrorMessage)
                .focused($focusedField, equals: .email)
                .onSubmit {
                    focusedField = .password
                }
                
                ZBRSecureTextField(text: $password,
                                   title: "Password",
                                   placeholder: "password",
                                   errorMessage: passwordErrorMessage)
                .focused($focusedField, equals: .password)
            }
            .padding(.top, 36)
            
            VStack (spacing: 30) {
                Button(action: {
                    Task {
                        await model.submit()
                    }
                }, label: {
                    Text("Sign In")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(.blue)
                        )
                        .foregroundStyle(.white)
                })
                .disabled(disableButtons)
                
                Button(action: {
                    action()
                }, label: {
                    HStack {
                        Text("Didn't have an account?")
                        Text("Create account")
                            .underline()
                    }
                    .font(.subheadline)
                    .foregroundStyle(Color.white)
                })
                .disabled(disableButtons)
                
            }
            .frame(height: 160)
        }
        .padding(.horizontal, 20)
    }
}
