import SwiftUI

@main
struct SaMaTiApp: App {
    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .preferredColorScheme(.light)
        }
    }
}
