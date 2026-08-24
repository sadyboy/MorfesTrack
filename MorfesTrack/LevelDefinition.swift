import Foundation
import Combine

// MARK: — Level Table
struct LevelDefinition {
    let level: Int
    let title: String
    let xpRequired: Int        // cumulative XP to reach this level
    let newAbility: String?
}

// MARK: — Engine
