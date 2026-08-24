import SwiftUI
import Combine

@MainActor
final class CelestialArcState: ObservableObject {

    // MARK: — Persistent (AppStorage-backed)
    @AppStorage("earnedXP")      var earnedXP: Int = 0
    @AppStorage("streakCount")   var streakCount: Int = 0
    @AppStorage("levelNumber")   var levelNumber: Int = 1
    @AppStorage("appInitialized") var appInitialized: Bool = false
    @AppStorage("easterEggTapCount") var easterEggTapCount: Int = 0
    @AppStorage("streakFreezeAvailable") var streakFreezeAvailable: Bool = false

    // MARK: — In-Memory Published
    @Published var selectedTab: Int = 0
    @Published var showLevelUpOverlay: Bool = false
    @Published var showConfetti: Bool = false
    @Published var showOnboarding: Bool = false
    @Published var currentSeasonalEvent: SeasonalEvent? = nil
    @Published var lastLevelUpInfo: LevelInfo? = nil

    // MARK: — Engines
    let progressEngine = CompetitiveProgressEngine()
    let streakTracker  = CompetitiveStreakTracker()
    let achievementVault = CompetitiveAchievementVault()

    private var cancellables = Set<AnyCancellable>()

    init() {
        if !appInitialized { showOnboarding = true }
        currentSeasonalEvent = SeasonalEventDetector.detect()
        bindEngines()
    }

    private func bindEngines() {
        progressEngine.$pendingLevelUp
            .filter { $0 != nil }
            .receive(on: RunLoop.main)
            .sink { [weak self] info in
                self?.lastLevelUpInfo = info
                self?.showLevelUpOverlay = true
                self?.showConfetti = true
            }
            .store(in: &cancellables)
    }

    func addXP(_ amount: Int) {
        let bonus = streakTracker.xpMultiplier()
        let total = Int(Double(amount) * bonus)
        earnedXP += total
        let (newLevel, didLevelUp) = progressEngine.evaluate(xp: earnedXP)
        if didLevelUp {
            levelNumber = newLevel
        }
    }

    func completeOnboarding(name: String) {
        UserDefaults.standard.set(name, forKey: "userName")
        appInitialized = true
        showOnboarding = false
        addXP(50) // earned during onboarding
    }
}

// MARK: — Supporting Types

struct LevelInfo {
    let level: Int
    let title: String
    let newAbility: String?
}

enum SeasonalEvent: String {
    case newYear    = "New Year Challenge"
    case spring     = "Spring Series"
    case summer     = "Summer Special"
    case yearReview = "Year in Review"

    var accentColor: Color {
        switch self {
        case .newYear:    return .white
        case .spring:     return Color(PawKit.amber)
        case .summer:     return Color(PawKit.leaf)
        case .yearReview: return Color(PawKit.coral)
        }
    }
}

enum SeasonalEventDetector {
    static func detect() -> SeasonalEvent? {
        let month = Calendar.current.component(.month, from: Date())
        switch month {
        case 1:        return .newYear
        case 3, 4:     return .spring
        case 7, 8:     return .summer
        case 12:       return .yearReview
        default:       return nil
        }
    }
}
