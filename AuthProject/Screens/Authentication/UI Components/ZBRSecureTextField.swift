//
//  ZBRSecureTextField.swift
//  Modular
//
//  Created by Max Ward on 30/10/2023.
//

import SwiftUI

struct ZBRSecureTextField: View {
    
    @Binding var text: String
    var title: String = ""
    var placeholder: String = ""
    var errorMessage: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.white)
            SecureField("",
                        text: $text,
                        prompt: Text("Password").foregroundStyle(Color.white.opacity(0.4)))
                .deafultTextFieldStyle()
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(errorMessage == "" ? .blueDark : .red, lineWidth: 1)
                })
                .overlay (alignment: .bottom) {
                    HStack {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundStyle(.red)
                        Spacer()
                    }
                    .offset(x: 16, y: 18)
                }
        }
        .padding(.bottom, 18)
    }
}
