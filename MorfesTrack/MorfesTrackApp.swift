import SwiftUI

struct MorfesTrackApp: View {
    @StateObject private var appState = CelestialArcState()
    @StateObject private var continuityEngine = SessionContinuityEngine()

    var body: some View {
        CelestialArcRootView()
            .environmentObject(appState)
            .environmentObject(continuityEngine)
            .preferredColorScheme(.dark)
    }
}
