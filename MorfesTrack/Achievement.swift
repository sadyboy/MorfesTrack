import Foundation
import Combine

// MARK: — Achievement Model
struct Achievement: Identifiable {
    let id: String
    let title: String
    let description: String
    let xpReward: Int
    let icon: String          // SF Symbol name
    let condition: AchievementCondition
}

enum AchievementCondition {
    case xpReached(Int)
    case levelReached(Int)
    case streakReached(Int)
    case lessonsCompleted(Int)
    case questionsAnswered(Int)
    case perfectQuiz               // 100% on any quiz
    case allLessonsComplete
}

// MARK: — Vault
final class CompetitiveAchievementVault: ObservableObject {

    @Published var newlyUnlocked: Achievement? = nil

    static let all: [Achievement] = [
        Achievement(id: "first_xp",       title: "First Drop",          description: "Earn your first XP.",                    xpReward: 10,  icon: "drop.fill",             condition: .xpReached(1)),
        Achievement(id: "xp_100",         title: "Substrate Layer",     description: "Reach 100 XP.",                          xpReward: 15,  icon: "square.stack.fill",     condition: .xpReached(100)),
        Achievement(id: "xp_500",         title: "CO₂ Flow",            description: "Reach 500 XP.",                          xpReward: 20,  icon: "wind",                  condition: .xpReached(500)),
        Achievement(id: "xp_1000",        title: "Planted Foundation",  description: "Reach 1,000 XP.",                        xpReward: 30,  icon: "leaf.fill",             condition: .xpReached(1000)),
        Achievement(id: "xp_5000",        title: "Competition Ready",   description: "Reach 5,000 XP.",                        xpReward: 50,  icon: "trophy.fill",           condition: .xpReached(5000)),
        Achievement(id: "xp_10000",       title: "IAPLC Contender",     description: "Reach 10,000 XP.",                       xpReward: 100, icon: "star.fill",             condition: .xpReached(10000)),
        Achievement(id: "level_5",        title: "Plant Keeper",        description: "Reach Level 5.",                         xpReward: 25,  icon: "5.circle.fill",         condition: .levelReached(5)),
        Achievement(id: "level_10",       title: "Top Contender",       description: "Reach Level 10.",                        xpReward: 50,  icon: "10.circle.fill",        condition: .levelReached(10)),
        Achievement(id: "level_20",       title: "Celestial Arc Master",description: "Reach the maximum level.",               xpReward: 200, icon: "crown.fill",            condition: .levelReached(20)),
        Achievement(id: "streak_3",       title: "3-Day Flow",          description: "Maintain a 3-day streak.",               xpReward: 15,  icon: "flame",                 condition: .streakReached(3)),
        Achievement(id: "streak_7",       title: "Week of Water",       description: "Maintain a 7-day streak.",               xpReward: 30,  icon: "flame.fill",            condition: .streakReached(7)),
        Achievement(id: "streak_30",      title: "Monthly Aquascaper",  description: "Maintain a 30-day streak.",              xpReward: 100, icon: "calendar",              condition: .streakReached(30)),
        Achievement(id: "streak_100",     title: "Century Streak",      description: "Maintain a 100-day streak.",             xpReward: 250, icon: "bolt.fill",             condition: .streakReached(100)),
        Achievement(id: "lessons_1",      title: "First Lesson",        description: "Complete your first lesson.",            xpReward: 10,  icon: "book.fill",             condition: .lessonsCompleted(1)),
        Achievement(id: "lessons_6",      title: "Halfway Through",     description: "Complete 6 lessons.",                    xpReward: 40,  icon: "books.vertical.fill",   condition: .lessonsCompleted(6)),
        Achievement(id: "lessons_all",    title: "Full Curriculum",     description: "Complete all 12 lessons.",               xpReward: 150, icon: "graduationcap.fill",    condition: .allLessonsComplete),
        Achievement(id: "questions_10",   title: "First Quiz Set",      description: "Answer 10 questions.",                   xpReward: 15,  icon: "questionmark.circle",   condition: .questionsAnswered(10)),
        Achievement(id: "questions_100",  title: "Quiz Veteran",        description: "Answer 100 questions.",                  xpReward: 50,  icon: "checkmark.seal.fill",   condition: .questionsAnswered(100)),
        Achievement(id: "perfect_quiz",   title: "Perfect Score",       description: "Achieve 100% on a quiz.",                xpReward: 40,  icon: "rosette",               condition: .perfectQuiz),
    ]

    // MARK: — Evaluation

    struct EvaluationContext {
        let totalXP: Int
        let level: Int
        let streak: Int
        let lessonsCompleted: Int
        let questionsAnswered: Int
        let perfectQuiz: Bool
        let allLessonsComplete: Bool
        let unlockedIDs: Set<String>
    }

    /// Returns newly unlocked achievements (not yet in unlockedIDs)
    func evaluate(context: EvaluationContext) -> [Achievement] {
        Self.all.filter { achievement in
            guard !context.unlockedIDs.contains(achievement.id) else { return false }
            return isMet(achievement.condition, context: context)
        }
    }

    private func isMet(_ condition: AchievementCondition, context: EvaluationContext) -> Bool {
        switch condition {
        case .xpReached(let target):         return context.totalXP >= target
        case .levelReached(let target):      return context.level >= target
        case .streakReached(let target):     return context.streak >= target
        case .lessonsCompleted(let target):  return context.lessonsCompleted >= target
        case .questionsAnswered(let target): return context.questionsAnswered >= target
        case .perfectQuiz:                   return context.perfectQuiz
        case .allLessonsComplete:            return context.allLessonsComplete
        }
    }
}
