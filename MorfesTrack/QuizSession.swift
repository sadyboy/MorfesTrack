import Foundation

// MARK: — Quiz Session Model
struct QuizSession {
    let questions: [CompetitiveQuestion]
    var currentIndex: Int = 0
    var answers: [Int?]         // user's chosen option index per question
    var startedAt: Date = Date()

    init(questions: [CompetitiveQuestion]) {
        self.questions = questions
        self.answers   = Array(repeating: nil, count: questions.count)
    }

    var currentQuestion: CompetitiveQuestion? {
        guard currentIndex < questions.count else { return nil }
        return questions[currentIndex]
    }

    var isComplete: Bool { currentIndex >= questions.count }

    var score: Int {
        zip(questions, answers).filter { question, answer in
            answer == question.correctIndex
        }.count
    }

    var totalXP: Int {
        zip(questions, answers).compactMap { question, answer -> Int? in
            guard answer == question.correctIndex else { return nil }
            return question.difficulty.xpReward
        }.reduce(0, +)
    }

    var isPerfect: Bool { score == questions.count }

    var accuracy: Double {
        guard !questions.isEmpty else { return 0 }
        return Double(score) / Double(questions.count)
    }

    mutating func answer(_ optionIndex: Int) {
        guard currentIndex < questions.count else { return }
        answers[currentIndex] = optionIndex
    }

    mutating func advance() {
        currentIndex += 1
    }
}

// MARK: — Library (query interface)
enum CompetitiveQuestionLibrary {

    // MARK: — Filtered Access

    static func questions(for lessonID: String) -> [CompetitiveQuestion] {
        CompetitiveQuestionBank.all.filter { $0.lessonID == lessonID }
    }

    static func questions(difficulty: CompetitiveQuestion.Difficulty) -> [CompetitiveQuestion] {
        CompetitiveQuestionBank.all.filter { $0.difficulty == difficulty }
    }

    static func questions(tags: [String]) -> [CompetitiveQuestion] {
        CompetitiveQuestionBank.all.filter { q in
            tags.contains(where: { q.tags.contains($0) })
        }
    }

    static var generalQuestions: [CompetitiveQuestion] {
        CompetitiveQuestionBank.all.filter { $0.lessonID == nil }
    }

    // MARK: — Quiz Builders

    /// Daily quiz: 5 mixed questions, not yet answered
    static func dailyQuiz(excluding completedIDs: Set<String>) -> QuizSession {
        let pool = CompetitiveQuestionBank.all
            .filter { !completedIDs.contains($0.id) }
            .shuffled()
        return QuizSession(questions: Array(pool.prefix(5)))
    }

    /// Lesson-specific quiz
    static func lessonQuiz(lessonID: String) -> QuizSession {
        let pool = questions(for: lessonID).shuffled()
        return QuizSession(questions: pool)
    }

    /// Difficulty challenge
    static func challengeQuiz(difficulty: CompetitiveQuestion.Difficulty, count: Int = 10) -> QuizSession {
        let pool = questions(difficulty: difficulty).shuffled()
        return QuizSession(questions: Array(pool.prefix(count)))
    }

    /// Random mixed quiz
    static func randomQuiz(count: Int = 10) -> QuizSession {
        let pool = CompetitiveQuestionBank.all.shuffled()
        return QuizSession(questions: Array(pool.prefix(count)))
    }

    // MARK: — Stats Helpers

    static func unansweredCount(completedIDs: Set<String>) -> Int {
        CompetitiveQuestionBank.all.filter { !completedIDs.contains($0.id) }.count
    }

    static func totalXPAvailable() -> Int {
        CompetitiveQuestionBank.all.map { $0.difficulty.xpReward }.reduce(0, +)
    }
}
