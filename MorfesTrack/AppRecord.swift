import Foundation

// MARK: — AppRecord
final class AppRecord {
    var totalXP: Int
    var levelNumber: Int
    var streakCount: Int
    var lastActiveDate: Date?
    var completedLessonIDs: [String]
    var completedQuestionIDs: [String]
    var unlockedAchievementIDs: [String]
    var streakFreezeAvailable: Bool
    var totalQuestionsAnswered: Int
    var totalCorrectAnswers: Int

    init() {
        totalXP = 0
        levelNumber = 1
        streakCount = 0
        lastActiveDate = nil
        completedLessonIDs = []
        completedQuestionIDs = []
        unlockedAchievementIDs = []
        streakFreezeAvailable = false
        totalQuestionsAnswered = 0
        totalCorrectAnswers = 0
    }
}

// MARK: — AchievementRecord
final class AchievementRecord {
    var achievementID: String
    var unlockedAt: Date
    var xpAwarded: Int

    init(achievementID: String, xpAwarded: Int) {
        self.achievementID = achievementID
        self.unlockedAt    = Date()
        self.xpAwarded     = xpAwarded
    }
}

// MARK: — SessionLog
final class SessionLog {
    var sessionID: String
    var startedAt: Date
    var endedAt: Date?
    var xpEarned: Int
    var lessonsCompleted: [String]
    var questionsAnswered: Int
    var correctAnswers: Int
    var sessionType: String  // "lesson" | "quiz" | "facts"

    init(sessionType: String) {
        self.sessionID         = UUID().uuidString
        self.startedAt         = Date()
        self.endedAt           = nil
        self.xpEarned          = 0
        self.lessonsCompleted  = []
        self.questionsAnswered = 0
        self.correctAnswers    = 0
        self.sessionType       = sessionType
    }

    func close(xpEarned: Int, questionsAnswered: Int, correctAnswers: Int) {
        self.endedAt           = Date()
        self.xpEarned          = xpEarned
        self.questionsAnswered = questionsAnswered
        self.correctAnswers    = correctAnswers
    }
}
