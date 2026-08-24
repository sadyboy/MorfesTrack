import Foundation
import Combine
import SwiftUI

// MARK: — Resume State
struct ResumeState {
    let type: ResumeType
    let lessonID: String?
    let questionID: String?
    let timestamp: Date

    enum ResumeType: String {
        case lesson, quiz, facts
    }
}

// MARK: — Engine
@MainActor
final class SessionContinuityEngine: ObservableObject {

    @Published var resumeState: ResumeState? = nil
    @Published var lastSessionSummary: SessionSummary? = nil

    private let defaults = UserDefaults.standard
    private let resumeKey = "sessionContinuityResume"

    struct SessionSummary {
        let xpEarned: Int
        let questionsAnswered: Int
        let correctAnswers: Int
        let sessionType: String
        let duration: TimeInterval
    }

    // MARK: — Persistence

    func saveResume(type: ResumeState.ResumeType, lessonID: String? = nil, questionID: String? = nil) {
        let dict: [String: Any] = [
            "type":       type.rawValue,
            "lessonID":   lessonID ?? "",
            "questionID": questionID ?? "",
            "timestamp":  Date().timeIntervalSince1970
        ]
        defaults.set(dict, forKey: resumeKey)
    }

    func loadResume() {
        guard let dict = defaults.dictionary(forKey: resumeKey),
              let typeRaw  = dict["type"] as? String,
              let type     = ResumeState.ResumeType(rawValue: typeRaw),
              let ts       = dict["timestamp"] as? TimeInterval
        else { return }

        let lessonID   = dict["lessonID"]   as? String
        let questionID = dict["questionID"] as? String
        let timestamp  = Date(timeIntervalSince1970: ts)

        // Only resume if session was within last 24 hours
        guard Date().timeIntervalSince(timestamp) < 86_400 else {
            clearResume()
            return
        }

        resumeState = ResumeState(
            type:       type,
            lessonID:   lessonID?.isEmpty == false ? lessonID : nil,
            questionID: questionID?.isEmpty == false ? questionID : nil,
            timestamp:  timestamp
        )
    }

    func clearResume() {
        defaults.removeObject(forKey: resumeKey)
        resumeState = nil
    }

    // MARK: — Session Summary

    func recordSummary(xpEarned: Int, questionsAnswered: Int, correctAnswers: Int,
                       sessionType: String, duration: TimeInterval) {
        lastSessionSummary = SessionSummary(
            xpEarned: xpEarned,
            questionsAnswered: questionsAnswered,
            correctAnswers: correctAnswers,
            sessionType: sessionType,
            duration: duration
        )
        clearResume()
    }
}
