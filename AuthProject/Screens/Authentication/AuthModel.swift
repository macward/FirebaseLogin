//
//  AuthModel.swift
//  Modular
//
//  Created by Max Ward on 19/10/2023.
//

import SwiftUI
import SwiftCommonLibrary
import SwiftAuthProxy
import Combine

class AuthModel: ObservableObject {
    
    enum AuthOption {
        case register
        case login
        case updateProfile
    }
    
    private var service: AuthenticationService
    
    @Published var authOption: AuthOption = .login
    @Published var email: String = String.empty
    @Published var password: String = String.empty
    @Published var emailErrorMessage: String = String.empty
    @Published var passwordErrorMessage: String = String.empty
    @Published var disableButtons: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    @AppStorage("waiting_email_confirmation") var waitingEmailConfirm: Bool = false
    
    private var publishers = Set<AnyCancellable>()
    private var emailValidator = EmailValidator()
    private var passwordValidator = NotEmptyValidator() //PasswordValidator()
    
    public init(service: AuthenticationService) {
        self.service = service
        self.addSubcribers()
    }
    
    private func addSubcribers() {
        // Clear error message after user start typing again
        $email
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.emailErrorMessage.clear()
            }
            .store(in: &publishers)
        
        // Clear error message after user start typing again
        $password
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.passwordErrorMessage.clear()
            }
            .store(in: &publishers)
    }
    
    @MainActor
    func setMode(_ option: AuthOption) {
        self.authOption = option
        resetForm()
    }
    // clear forms and button states
    private func resetForm() {
        email.clear()
        password.clear()
        emailErrorMessage.clear()
        passwordErrorMessage.clear()
        disableButtons.turnOff()
        isLoading.turnOff()
    }
    
    // validate input data and submit forms
    @MainActor
    func submit() async {
        
        disableButtons.turnOn()
        
        guard emailValidator.validate(email) else {
            emailErrorMessage = emailValidator.errorMessage
            disableButtons.turnOff()
            return
        }
        guard passwordValidator.validate(password) else {
            passwordErrorMessage = passwordValidator.errorMessage
            disableButtons.turnOff()
            return
        }
        
        isLoading.turnOn()
        authOption == .register ? await signup(email: self.email, password: self.password) :
                                  await signin(email: self.email, password: self.password)
        disableButtons.turnOff()
        isLoading.turnOff()
    }
    
    private func signin(email: String, password: String) async {
        do {
            let user = try await service.signin(email: email, password: password)
            print(user.email)
        } catch {
            errorMessage = "Please, check your credentials"
        }
    }
    
    private func signup(email: String, password: String) async {
        do {
            let user = try await service.signup(email: email, password: password)
            print(user.email)
        } catch (let error) {
            errorMessage = error.localizedDescription
        }
    }
}

extension AuthModel: AuthUser {}
extension AuthModel {
    public static func instance() -> AuthModel {
        return AuthModel(service: FirebaseEmailAuthenticationService())
    }
}
