import Foundation
import Combine

// ═══════════════════════════════════════════════════════════
// CareEngine — Gamification Engines
// XP / Streak / Achievements for Competitive Aquarium Design
// ═══════════════════════════════════════════════════════════

// MARK: — XP / Level Engine

@MainActor
final class CompetitiveProgressEngine: ObservableObject {

    @Published var pendingLevelUp: LevelInfo? = nil

    // MARK: — Level Table (20 levels)
    static let levels: [LevelDefinition] = [
        LevelDefinition(level: 1,  title: "Freshwater Novice",      xpRequired: 0,    newAbility: nil),
        LevelDefinition(level: 2,  title: "Substrate Learner",      xpRequired: 100,  newAbility: "Unlock: Daily Quiz"),
        LevelDefinition(level: 3,  title: "Water Reader",           xpRequired: 250,  newAbility: "Unlock: Fact Vault"),
        LevelDefinition(level: 4,  title: "CO₂ Apprentice",         xpRequired: 450,  newAbility: "Unlock: Lesson Library"),
        LevelDefinition(level: 5,  title: "Plant Keeper",           xpRequired: 700,  newAbility: "Unlock: Streak Freeze"),
        LevelDefinition(level: 6,  title: "Hardscape Student",      xpRequired: 1000, newAbility: "Unlock: Advanced Quizzes"),
        LevelDefinition(level: 7,  title: "Iwagumi Initiate",       xpRequired: 1400, newAbility: "Unlock: Expert Facts"),
        LevelDefinition(level: 8,  title: "Dutch Apprentice",       xpRequired: 1900, newAbility: "Unlock: Dutch Style Lessons"),
        LevelDefinition(level: 9,  title: "Algae Diagnostician",    xpRequired: 2500, newAbility: "Unlock: Diagnostic Mode"),
        LevelDefinition(level: 10, title: "Competition Contender",  xpRequired: 3200, newAbility: "Unlock: Competition Timeline"),
        LevelDefinition(level: 11, title: "Aquascape Architect",    xpRequired: 4100, newAbility: "Unlock: Composition Tools"),
        LevelDefinition(level: 12, title: "Filter Master",          xpRequired: 5200, newAbility: "Unlock: Equipment Deep Dives"),
        LevelDefinition(level: 13, title: "Stone Selector",         xpRequired: 6500, newAbility: "Unlock: Hardscape Vault"),
        LevelDefinition(level: 14, title: "Fertilization Expert",   xpRequired: 8000, newAbility: "Unlock: EI Protocols"),
        LevelDefinition(level: 15, title: "Photography Finalist",   xpRequired: 9800, newAbility: "Unlock: Photography Guide"),
        LevelDefinition(level: 16, title: "IAPLC Qualifier",        xpRequired: 12000, newAbility: "Unlock: Judge Scoring"),
        LevelDefinition(level: 17, title: "Nature Aquarium Artist", xpRequired: 14500, newAbility: "Unlock: Amano Archive"),
        LevelDefinition(level: 18, title: "Grand Prix Contender",   xpRequired: 17500, newAbility: "Unlock: Championship Mode"),
        LevelDefinition(level: 19, title: "World-Class Aquascaper", xpRequired: 21000, newAbility: "Unlock: Master Challenges"),
        LevelDefinition(level: 20, title: "Celestial Arc Master",   xpRequired: 25000, newAbility: "You have mastered the arc."),
    ]

    // MARK: — Public API

    /// Returns (newLevel, didLevelUp)
    func evaluate(xp: Int) -> (Int, Bool) {
        let currentLevel = levelFor(xp: xp)
        let previousLevel = levelFor(xp: xp - 1)
        if currentLevel > previousLevel {
            let def = Self.levels.first { $0.level == currentLevel }
            pendingLevelUp = LevelInfo(
                level: currentLevel,
                title: def?.title ?? "Level \(currentLevel)",
                newAbility: def?.newAbility
            )
            return (currentLevel, true)
        }
        return (currentLevel, false)
    }

    func levelFor(xp: Int) -> Int {
        let def = Self.levels.last { $0.xpRequired <= xp }
        return def?.level ?? 1
    }

    func xpForNextLevel(currentXP: Int) -> Int {
        let currentLevel = levelFor(xp: currentXP)
        guard let next = Self.levels.first(where: { $0.level == currentLevel + 1 }) else {
            return currentXP // max level
        }
        return next.xpRequired
    }

    func progressFraction(currentXP: Int) -> Double {
        let currentLevel = levelFor(xp: currentXP)
        guard let current = Self.levels.first(where: { $0.level == currentLevel }),
              let next    = Self.levels.first(where: { $0.level == currentLevel + 1 })
        else { return 1.0 }
        let range = next.xpRequired - current.xpRequired
        let earned = currentXP - current.xpRequired
        return min(1.0, max(0.0, Double(earned) / Double(range)))
    }

    func titleFor(level: Int) -> String {
        Self.levels.first { $0.level == level }?.title ?? "Level \(level)"
    }
}




enum SessionAction {
    case reviewWeakTopics([String])
    case continueTutorial
    case nextLesson(after: String)
}

