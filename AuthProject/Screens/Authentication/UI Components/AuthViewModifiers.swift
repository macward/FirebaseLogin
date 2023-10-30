//
//  AuthViewModifiers.swift
//  Modular
//
//  Created by Max Ward on 30/10/2023.
//

import SwiftUI

struct TextFieldStyleViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.body)
            .padding()
            .background(Color.blueAccent)
            .mask(RoundedRectangle(cornerRadius: 10))
            .foregroundStyle(Color.white)
    }
}

extension View {
    func deafultTextFieldStyle() -> some View {
        modifier(TextFieldStyleViewModifier())
    }
}
