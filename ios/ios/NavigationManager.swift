//
//  NavigationManager.swift
//  ios
//
//  Created by umtlab03im13 on 9/4/25.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var shouldNavigateToHome: Bool = false
    
    func resetToHome() {
        shouldNavigateToHome = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.shouldNavigateToHome = false
        }
    }
}
