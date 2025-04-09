//
//  iosApp.swift
//  ios
//
//  Created by umtlab03im13 on 13/3/25.
//

import SwiftUI
import Firebase
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            AuthenticationView()
                .environmentObject(navigationManager)
        }
    }
}
