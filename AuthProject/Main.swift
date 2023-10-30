//
//  AuthProjectApp.swift
//  AuthProject
//
//  Created by Max Ward on 30/10/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import SwiftAuthProxy

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ModularApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var appStateManager = GlobalStateManager()
    var body: some Scene {
        WindowGroup {
            AuthContainerView(isAuth: appStateManager.isAuth) {
                AccountScreen()
            } guestView: {
                AuthScreen(model: AuthModel.instance())
            }
            .preferredColorScheme(.light)
        }
    }
}
