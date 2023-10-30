//
//  AuthScreen.swift
//  Modular
//
//  Created by Max Ward on 19/10/2023.
//

import SwiftUI
import SwiftCommonLibrary
import SwiftAuthProxy

struct AuthScreen: View {
    
    @StateObject var model: AuthModel
    var gradient = RadialGradient(colors: [.blueAccent, .blueDark],
                                  center: .center,
                                  startRadius: 0,
                                  endRadius: 400)
    
    var body: some View {
        GradientContainerView(background: gradient) {
            VStack {
                NavBarView { model.setMode(.login) }
                .offset(y: self.navBarPositionOffset())
                .animation(.interactiveSpring(response: 0.6, 
                                              dampingFraction: 0.85,
                                              blendDuration: 0.5), value: model.authOption)
                logo()
                ZStack {
                    signInView()
                    createAccountView()
                }
                .animation(.interactiveSpring(response: 0.4, 
                                              dampingFraction: 0.85,
                                              blendDuration: 0.5), value: model.authOption)
            }
            .activityIndicatorDefault(isLoading: model.isLoading)
        }
    }
    
    func logo() -> some View {
        Image("zibra_logo")
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .foregroundStyle(Color.white)
            .padding(.top, 32)
    }
    
    func signInView() -> some View {
        GeometryReader(content: { geometry in
            SignInView(email: $model.email,
                       password: $model.password,
                       emailErrorMessage: model.emailErrorMessage,
                       passwordErrorMessage: model.passwordErrorMessage,
                       disableButtons: model.disableButtons,
                       model: model) {
                withAnimation {
                    model.setMode(.register)
                }
            }
            .offset(x: model.authOption == .login ? 0 : -geometry.size.width)
        })
    }
    
    func createAccountView() -> some View {
        GeometryReader(content: { geometry in
            CreateAccountView(email: $model.email,
                              password: $model.password,
                              emailErrorMessage: $model.emailErrorMessage,
                              passwordErrorMessage: $model.passwordErrorMessage,
                              disableButtons: $model.disableButtons,
                              model: model)
            .offset(x: self.createAccountPositionOffset(geometry.size))
        })
    }
    
    private func navBarPositionOffset() -> CGFloat {
        switch model.authOption {
        case .login: return -120
        case .register: return 0
        case .updateProfile: return -120
        }
    }
    
    private func updateProfilePositionOffset(_ geometry: CGSize) -> CGFloat {
        switch model.authOption {
        case .login: return geometry.width
        case .register: return geometry.width
        case .updateProfile: return 0
        }
    }
    
    private func createAccountPositionOffset(_ geometry: CGSize) -> CGFloat {
        switch model.authOption {
        case .login: return geometry.width
        case .register: return 0
        case .updateProfile: return -geometry.width
        }
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}


#Preview {
    AuthScreen(model: AuthModel.instance())
}
