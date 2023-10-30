//
//  AppManager.swift
//  Modular
//
//  Created by Max Ward on 28/10/2023.
//

import Foundation
import SwiftAuthProxy
import SwiftUI

public class GlobalStateManager: ObservableObject {
    @Published var isAuth: Bool = false
    // store the auth state into UserDefault, it is useful when the app start
    // and show the correct screen
    @AppStorage("auth_state") private var authState: Bool = false
    
    public init() {
        addObserver()
        isAuth = authState
    }
    
    private func addObserver() {
        AuthenticationManager.listener { isAuth in
            self.authState = isAuth
            self.isAuth = self.authState
        }
    }
}
