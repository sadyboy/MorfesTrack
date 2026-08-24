import SwiftUI

struct SplashView: View {

    let onFinish: () -> Void

    @State private var iconScale: CGFloat   = 0.3
    @State private var iconOpacity: Double  = 0
    @State private var textOpacity: Double  = 0
    @State private var ripple1Scale: CGFloat = 0.1
    @State private var ripple2Scale: CGFloat = 0.1
    @State private var ripple1Op: Double    = 0.5
    @State private var ripple2Op: Double    = 0.4
    @State private var finishing: Bool      = false

    var body: some View {
        ZStack {
            Color(PawKit.forestDeep).ignoresSafeArea()

            // Ripple rings expanding outward
            Circle()
                .stroke(PawKit.cLeaf.opacity(ripple1Op), lineWidth: 1.5)
                .scaleEffect(ripple1Scale)
                .frame(width: 180, height: 180)

            Circle()
                .stroke(PawKit.cLeaf.opacity(ripple2Op), lineWidth: 1)
                .scaleEffect(ripple2Scale)
                .frame(width: 180, height: 180)

            // Center content
            VStack(spacing: 20) {

                // Icon with subtle glow ring
                ZStack {
                    Circle()
                        .fill(PawKit.cLeaf.opacity(0.08))
                        .frame(width: 130, height: 130)

                    Image(systemName: "water.waves")
                        .font(.system(size: 64, weight: .thin))
                        .foregroundColor(PawKit.cLeaf)
                }
                .scaleEffect(iconScale)
                .opacity(iconOpacity)

                VStack(spacing: 6) {
                    Text("Blingox Luck")
                        .font(PawKit.swiftFont(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .tracking(0.5)

                    Text("Competitive Aquascaping")
                        .font(PawKit.swiftFont(size: 14))
                        .foregroundColor(PawKit.cMist.opacity(0.65))
                        .tracking(1.5)
                }
                .opacity(textOpacity)
            }
        }
        .opacity(finishing ? 0 : 1)
        .onAppear { animate() }
    }

    private func animate() {
        // Icon springs in
        withAnimation(.spring(response: 0.55, dampingFraction: 0.62).delay(0.1)) {
            iconScale   = 1.0
            iconOpacity = 1.0
        }
        // Text fades in
        withAnimation(.easeOut(duration: 0.4).delay(0.45)) {
            textOpacity = 1.0
        }
        // Ripple 1
        withAnimation(.easeOut(duration: 1.3).delay(0.2)) {
            ripple1Scale = 3.2
            ripple1Op   = 0
        }
        // Ripple 2 (slightly delayed & larger)
        withAnimation(.easeOut(duration: 1.5).delay(0.5)) {
            ripple2Scale = 4.2
            ripple2Op   = 0
        }
        // Fade out and finish
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.9) {
            withAnimation(.easeIn(duration: 0.35)) { finishing = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { onFinish() }
        }
    }
}
