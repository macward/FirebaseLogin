//
//  CreateAccountView.swift
//  Modular
//
//  Created by Max Ward on 29/10/2023.
//

import SwiftUI
import SwiftAuthProxy
import SwiftCommonLibrary
import Combine

protocol AuthUser {
    func submit() async
}

struct CreateAccountView: View {
    
    enum Field {
        case None
        case email
        case password
    }
    @FocusState private var focusedField: Field?
    
    var model: AuthUser
    
    @Binding var email: String
    @Binding var password: String
    @Binding var emailErrorMessage: String
    @Binding var passwordErrorMessage: String
    @Binding var disableButtons: Bool
    
    init(email: Binding<String>, password: Binding<String>,
         emailErrorMessage: Binding<String>,
         passwordErrorMessage: Binding<String>,
         disableButtons: Binding<Bool>,
         model: AuthUser) {
        self._email = email
        self._password = password
        self._emailErrorMessage = emailErrorMessage
        self._passwordErrorMessage = passwordErrorMessage
        self._disableButtons = disableButtons
        self.model = model
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
            
            Button(action: {
                Task {
                    await model.submit()
                }
            }, label: {
                Text("Create Account")
                    .bold()
                    .frame(width: 200, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(.blue)
                    )
                    .foregroundStyle(.white)
            })
            .disabled(disableButtons)
        }
        .padding(.horizontal, 20)
    }
}
