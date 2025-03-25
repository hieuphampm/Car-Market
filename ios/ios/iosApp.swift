//
//  iosApp.swift
//  ios
//
//  Created by umtlab03im13 on 13/3/25.
//

import SwiftUI
import Firebase
import FirebaseCore

// AppDelegate để cấu hình Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct iosApp: App {
    // Kết nối AppDelegate với SwiftUI App Lifecycle
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            AuthenticationView()
        }
    }
}
    
