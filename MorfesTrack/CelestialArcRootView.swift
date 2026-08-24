import SwiftUI
import UIKit

struct CelestialArcRootView: View {

    @EnvironmentObject private var appState: CelestialArcState
    @EnvironmentObject private var continuityEngine: SessionContinuityEngine
    @State private var showSplash = true

    var body: some View {
        ZStack {
         if appState.showOnboarding {
                OnboardingFlowView()
                    .transition(.opacity)
            } else {
                MainTabView()
                    .transition(.opacity)
            }

            if appState.showLevelUpOverlay, let info = appState.lastLevelUpInfo {
                LevelUpOverlayView(info: info) {
                    appState.showLevelUpOverlay = false
                    appState.showConfetti = false
                }
                .transition(.scale.combined(with: .opacity))
                .zIndex(10)
            }

            if appState.showConfetti {
                ConfettiView()
                    .allowsHitTesting(false)
                    .zIndex(9)
            }
        }
        .animation(.easeInOut(duration: 0.4), value: showSplash)
        .animation(.easeInOut(duration: 0.35), value: appState.showOnboarding)
        .animation(.spring(response: 0.4, dampingFraction: 0.75), value: appState.showLevelUpOverlay)
        .onAppear {
            continuityEngine.loadResume()
        }
    }
}

// MARK: — Main Tab View

private struct MainTabView: View {

    @EnvironmentObject private var appState: CelestialArcState

    var body: some View {
        TabView(selection: $appState.selectedTab) {

            HomeView()
                .tabItem { Label("Home",      systemImage: "water.waves") }
                .tag(0)

            LessonsView()
                .tabItem { Label("Learn",     systemImage: "graduationcap.fill") }
                .tag(1)

            QuizView()
                .tabItem { Label("Challenge", systemImage: "bolt.circle.fill") }
                .tag(2)

            TankLogView()
                .tabItem { Label("Tank Log",  systemImage: "drop.fill") }
                .tag(3)

            ProfileView()
                .tabItem { Label("Rank",      systemImage: "trophy.fill") }
                .tag(4)
        }
        .tint(PawKit.cAmber)
        .onAppear { configureTabBarAppearance() }
    }

    private func configureTabBarAppearance() {
        let a = UITabBarAppearance()
        a.configureWithOpaqueBackground()
        a.backgroundColor = UIColor(hex: "#050C07")
        let unsel = UITabBarItemAppearance()
        unsel.normal.iconColor       = UIColor(hex: "#3D5C44")
        unsel.normal.titleTextAttributes = [.foregroundColor: UIColor(hex: "#3D5C44")]
        a.stackedLayoutAppearance   = unsel
        a.inlineLayoutAppearance    = unsel
        a.compactInlineLayoutAppearance = unsel
        UITabBar.appearance().standardAppearance   = a
        UITabBar.appearance().scrollEdgeAppearance = a
    }
}

// MARK: — Onboarding Flow View

private struct OnboardingFlowView: View {

    @EnvironmentObject private var appState: CelestialArcState
    @State private var currentStep: Int  = 0
    @State private var name: String      = ""

    private let steps: [OnboardingStep] = [
        OnboardingStep(
            icon:     "trophy.fill",
            color:    PawKit.cGold,
            tag:      "IAPLC · AGA · ADA",
            headline: "Train Like a Champion",
            body:     "Top aquascapers study water chemistry, plant dynamics, and layout principles every single day. Blingox Luck is your daily edge."
        ),
        OnboardingStep(
            icon:     "drop.fill",
            color:    PawKit.cLeaf,
            tag:      "Tank Log",
            headline: "Know Your Water",
            body:     "Log pH, ammonia, nitrite, nitrate, and temperature. The app diagnoses your readings and tells you exactly what to fix."
        ),
        OnboardingStep(
            icon:     "graduationcap.fill",
            color:    PawKit.cAmber,
            tag:      "12 Lessons",
            headline: "Learn from the Best",
            body:     "Structured lessons on Iwagumi composition, the nitrogen cycle, CO₂ injection, and competitive plant selection — from scratch to podium."
        ),
    ]

    var body: some View {
        ZStack {
            Color(PawKit.forestDeep).ignoresSafeArea()

            VStack(spacing: 0) {

                // Swipeable pages
                TabView(selection: $currentStep) {
                    ForEach(steps.indices, id: \.self) { i in
                        OnboardingStepPage(step: steps[i])
                            .tag(i)
                    }
                    // Final name step
                    NameEntryPage(name: $name)
                        .tag(steps.count)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.easeInOut(duration: 0.3), value: currentStep)

                // Progress dots
                HStack(spacing: 8) {
                    ForEach(0...(steps.count), id: \.self) { i in
                        Capsule()
                            .fill(i == currentStep ? PawKit.cLeaf : PawKit.cMist.opacity(0.3))
                            .frame(width: i == currentStep ? 22 : 7, height: 7)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: currentStep)
                    }
                }
                .padding(.top, 12)

                // Action button
                actionButton
                    .padding(.top, 20)
                    .padding(.bottom, 36)
                    .padding(.horizontal, 28)
            }
        }
    }

    @ViewBuilder
    private var actionButton: some View {
        let isLast = currentStep == steps.count
        let canFinish = isLast && !name.trimmingCharacters(in: .whitespaces).isEmpty

        Button {
            if isLast {
                let trimmed = name.trimmingCharacters(in: .whitespaces)
                guard !trimmed.isEmpty else { return }
                PawKit.haptics.success()
                appState.completeOnboarding(name: trimmed)
            } else {
                withAnimation { currentStep += 1 }
            }
        } label: {
            HStack(spacing: 8) {
                Text(isLast ? (canFinish ? "Start Tracking" : "Enter your name") : "Continue")
                    .font(PawKit.swiftFont(size: 17, weight: .semibold))
                if !isLast {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 15, weight: .semibold))
                }
            }
            .foregroundColor(Color(PawKit.forestDeep))
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(isLast ? (canFinish ? PawKit.cLeaf : PawKit.cMist.opacity(0.3)) : PawKit.cLeaf)
            .cornerRadius(PawKit.Radius.button)
        }
        .disabled(isLast && !canFinish)
    }
}

private struct OnboardingStep {
    let icon: String
    let color: Color
    let tag: String
    let headline: String
    let body: String
}

private struct OnboardingStepPage: View {

    let step: OnboardingStep
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Icon circle with glow
            ZStack {
                Circle()
                    .fill(step.color.opacity(0.1))
                    .frame(width: 140, height: 140)
                Circle()
                    .fill(step.color.opacity(0.06))
                    .frame(width: 200, height: 200)
                Image(systemName: step.icon)
                    .font(.system(size: 60, weight: .thin))
                    .foregroundColor(step.color)
            }
            .scaleEffect(appeared ? 1.0 : 0.7)
            .opacity(appeared ? 1.0 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.65).delay(0.05), value: appeared)

            Spacer().frame(height: 36)

            // Tag chip
            Text(step.tag)
                .font(PawKit.swiftFont(size: 11, weight: .semibold))
                .foregroundColor(step.color)
                .tracking(1.8)
                .padding(.horizontal, 12)
                .padding(.vertical, 5)
                .background(step.color.opacity(0.12))
                .clipShape(Capsule())
                .opacity(appeared ? 1.0 : 0)
                .animation(.easeOut(duration: 0.3).delay(0.2), value: appeared)

            Spacer().frame(height: 18)

            Text(step.headline)
                .font(PawKit.swiftFont(size: 28, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .opacity(appeared ? 1.0 : 0)
                .animation(.easeOut(duration: 0.35).delay(0.25), value: appeared)

            Spacer().frame(height: 14)

            Text(step.body)
                .font(PawKit.swiftFont(size: 15))
                .foregroundColor(PawKit.cMist.opacity(0.72))
                .multilineTextAlignment(.center)
                .lineSpacing(4)
                .padding(.horizontal, 36)
                .opacity(appeared ? 1.0 : 0)
                .animation(.easeOut(duration: 0.35).delay(0.32), value: appeared)

            Spacer()
        }
        .onAppear { appeared = true }
        .onDisappear { appeared = false }
    }
}

private struct NameEntryPage: View {

    @Binding var name: String
    @State private var appeared = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            ZStack {
                Circle()
                    .fill(PawKit.cLeaf.opacity(0.1))
                    .frame(width: 140, height: 140)
                Image(systemName: "person.fill")
                    .font(.system(size: 58, weight: .thin))
                    .foregroundColor(PawKit.cLeaf)
            }
            .scaleEffect(appeared ? 1.0 : 0.7)
            .opacity(appeared ? 1.0 : 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.65).delay(0.05), value: appeared)

            Spacer().frame(height: 32)

            Text("One Last Thing")
                .font(PawKit.swiftFont(size: 28, weight: .bold))
                .foregroundColor(.white)
                .opacity(appeared ? 1.0 : 0)
                .animation(.easeOut(duration: 0.35).delay(0.2), value: appeared)

            Spacer().frame(height: 10)

            Text("What should we call you?")
                .font(PawKit.swiftFont(size: 15))
                .foregroundColor(PawKit.cMist.opacity(0.72))
                .opacity(appeared ? 1.0 : 0)
                .animation(.easeOut(duration: 0.35).delay(0.25), value: appeared)

            Spacer().frame(height: 32)

            TextField("Your name", text: $name)
                .padding(16)
                .background(Color(PawKit.forestDark))
                .cornerRadius(PawKit.Radius.button)
                .foregroundColor(.white)
                .font(PawKit.swiftFont(size: 16))
                .padding(.horizontal, 28)
                .opacity(appeared ? 1.0 : 0)
                .animation(.easeOut(duration: 0.35).delay(0.32), value: appeared)

            Spacer()
        }
        .onAppear { appeared = true }
        .onDisappear { appeared = false }
    }
}

// MARK: — Level Up Overlay

struct LevelUpOverlayView: View {

    let info: LevelInfo
    let onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.opacity(0.75).ignoresSafeArea()
                .onTapGesture { onDismiss() }

            VStack(spacing: PawKit.Spacing.l) {

                Image(systemName: "crown.fill")
                    .font(.system(size: 52))
                    .foregroundColor(PawKit.cGold)

                VStack(spacing: PawKit.Spacing.s) {
                    Text("Level Up!")
                        .font(PawKit.swiftFont(size: 32, weight: .bold))
                        .foregroundColor(.white)

                    Text("Level \(info.level) — \(info.title)")
                        .font(PawKit.swiftFont(size: 18, weight: .medium))
                        .foregroundColor(PawKit.cLeaf)
                }

                if let ability = info.newAbility {
                    Text(ability)
                        .font(PawKit.swiftFont(size: 14))
                        .foregroundColor(PawKit.cMist)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, PawKit.Spacing.l)
                }

                Button {
                    PawKit.haptics.levelUpPattern()
                    onDismiss()
                } label: {
                    Text("Continue")
                        .font(PawKit.swiftFont(size: 17, weight: .semibold))
                        .foregroundColor(Color(PawKit.forestDeep))
                        .frame(width: 200)
                        .padding()
                        .background(PawKit.cGold)
                        .cornerRadius(PawKit.Radius.button)
                }
            }
            .padding(PawKit.Spacing.xl)
            .background(Color(PawKit.forestDark))
            .cornerRadius(PawKit.Radius.card)
            .shadow(color: .black.opacity(0.5), radius: 24, x: 0, y: 8)
            .padding(PawKit.Spacing.xl)
        }
    }
}

// MARK: — Confetti View

struct ConfettiView: View {

    @State private var particles: [ConfettiParticle] = []
    @State private var animating: Bool = false

    struct ConfettiParticle: Identifiable {
        let id = UUID()
        let x: CGFloat
        let startY: CGFloat
        let color: Color
        let rotation: Double
        let scale: CGFloat
        let speed: Double
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { p in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(p.color)
                        .frame(width: 8, height: 8)
                        .scaleEffect(p.scale)
                        .rotationEffect(.degrees(animating ? p.rotation + 360 : p.rotation))
                        .position(
                            x: p.x,
                            y: animating ? geo.size.height + 20 : p.startY
                        )
                        .animation(
                            .linear(duration: p.speed).delay(Double.random(in: 0...0.8)),
                            value: animating
                        )
                }
            }
            .onAppear {
                spawnParticles(in: geo.size)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    animating = true
                }
            }
        }
        .ignoresSafeArea()
    }

    private func spawnParticles(in size: CGSize) {
        let colors: [Color] = [PawKit.cLeaf, PawKit.cAmber, PawKit.cGold, PawKit.cCoral, PawKit.cMist]
        particles = (0..<70).map { _ in
            ConfettiParticle(
                x:        CGFloat.random(in: 0...size.width),
                startY:   CGFloat.random(in: -40...size.height * 0.3),
                color:    colors.randomElement()!,
                rotation: Double.random(in: 0...360),
                scale:    CGFloat.random(in: 0.5...1.5),
                speed:    Double.random(in: 1.5...3.5)
            )
        }
    }
}

// MARK: — Tab Screen Wrappers (UIKit via UIViewControllerRepresentable)

struct HomeView: View {
    var body: some View {
        HomeRepresentable()
            .ignoresSafeArea()
    }
}

struct LessonsView: View {
    var body: some View {
        LessonsRepresentable()
            .ignoresSafeArea()
    }
}

struct QuizView: View {
    var body: some View {
        QuizRepresentable()
            .ignoresSafeArea()
    }
}

struct TankLogView: View {
    var body: some View {
        TankLogRepresentable()
            .ignoresSafeArea()
    }
}

struct ProfileView: View {
    var body: some View {
        ProfileRepresentable()
            .ignoresSafeArea()
    }
}

// MARK: — UIViewControllerRepresentable Bridges

private struct HomeRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        wrapInNav(HomeViewController(), title: "Home")
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

private struct LessonsRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        wrapInNav(LessonsViewController(), title: "Lessons")
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

private struct QuizRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        wrapInNav(QuizViewController(), title: "Quiz")
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

private struct TankLogRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        wrapInNav(WaterLogViewController(), title: "Tank Log")
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

private struct ProfileRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UINavigationController {
        wrapInNav(ProfileViewController(), title: "Profile")
    }
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}
}

// MARK: — Nav helper

private func wrapInNav(_ root: UIViewController, title: String) -> UINavigationController {
    root.title = title
    let nav = UINavigationController(rootViewController: root)
    nav.navigationBar.prefersLargeTitles = true

    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor(hex: "#050C07")
    appearance.titleTextAttributes = [
        .foregroundColor: UIColor.white,
        .font: PawKit.Font.mono(17),
    ]
    appearance.largeTitleTextAttributes = [
        .foregroundColor: UIColor.white,
        .font: PawKit.Font.hero(32),
    ]
    // Thin amber separator line under nav bar
    appearance.shadowColor = PawKit.amber.withAlphaComponent(0.25)

    nav.navigationBar.standardAppearance   = appearance
    nav.navigationBar.scrollEdgeAppearance = appearance
    nav.navigationBar.tintColor            = PawKit.amber
    return nav
}
