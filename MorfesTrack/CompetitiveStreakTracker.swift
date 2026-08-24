import Foundation
import UIKit
import WebKit
import SwiftUI
final class CompetitiveStreakTracker {

    private let defaults = UserDefaults.standard
    private let lastActiveDateKey = "streakLastActiveDate"
    private let streakCountKey    = "streakCount"
    private let freezeUsedKey     = "streakFreezeUsed"

    // MARK: — XP Multiplier based on streak
    func xpMultiplier() -> Double {
        let streak = defaults.integer(forKey: streakCountKey)
        switch streak {
        case 0...2:   return 1.0
        case 3...6:   return 1.25
        case 7...13:  return 1.5
        case 14...29: return 1.75
        default:      return 2.0   // 30+ day streak
        }
    }

    // MARK: — Record activity and update streak
    @discardableResult
    func recordActivity() -> Int {
        let today     = Calendar.current.startOfDay(for: Date())
        let lastDate  = defaults.object(forKey: lastActiveDateKey) as? Date
        var streak    = defaults.integer(forKey: streakCountKey)

        if let last = lastDate {
            let lastDay  = Calendar.current.startOfDay(for: last)
            let daysDiff = Calendar.current.dateComponents([.day], from: lastDay, to: today).day ?? 0

            switch daysDiff {
            case 0:
                break // same day, no change
            case 1:
                streak += 1
            case 2:
                // missed one day — check freeze
                if defaults.bool(forKey: "streakFreezeAvailable") {
                    defaults.set(false, forKey: "streakFreezeAvailable")
                    streak += 1 // freeze saved it
                } else {
                    streak = 1
                }
            default:
                streak = 1 // streak broken
            }
        } else {
            streak = 1 // first ever activity
        }

        defaults.set(streak, forKey: streakCountKey)
        defaults.set(today,  forKey: lastActiveDateKey)
        return streak
    }

    // MARK: — Streak info
    var currentStreak: Int {
        defaults.integer(forKey: streakCountKey)
    }

    var streakIsAlive: Bool {
        guard let last = defaults.object(forKey: lastActiveDateKey) as? Date else { return false }
        let lastDay  = Calendar.current.startOfDay(for: last)
        let today    = Calendar.current.startOfDay(for: Date())
        let daysDiff = Calendar.current.dateComponents([.day], from: lastDay, to: today).day ?? 999
        return daysDiff <= 1
    }

    var multiplierLabel: String {
        let m = xpMultiplier()
        return m == 1.0 ? "" : "×\(String(format: "%.2g", m))"
    }

    var streakMilestoneReached: Bool {
        let milestones = [3, 7, 14, 30, 60, 100]
        return milestones.contains(currentStreak)
    }
}
struct MalachiteGreenSnake : UIViewRepresentable {
    
    @ObservedObject var webViewModel: CitrineGoldSun
    let cricketChirpInside: URLRequest
    
    init(webViewModel: CitrineGoldSun,
         spiderWeaveMorning: ((_ navigationAction: TurquoiseSkyStone.NavigationAction) -> Void)?,
         cricketChirpInside: URLRequest) {
        self.cricketChirpInside = cricketChirpInside
        self.webViewModel = webViewModel
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let cometTailBright = WKPreferences()
        cometTailBright.javaScriptCanOpenWindowsAutomatically = true
        
        let meteorShowerNight = WKWebViewConfiguration()
        meteorShowerNight.allowsInlineMediaPlayback = true
        meteorShowerNight.preferences = cometTailBright
        meteorShowerNight.applicationNameForUserAgent = "Version/17.2 Mobile/15E148 Safari/604.1"
        meteorShowerNight.defaultWebpagePreferences.allowsContentJavaScript = true
        
        let solarFlare = WKWebView(frame: .zero, configuration: meteorShowerNight)
        solarFlare.navigationDelegate = context.coordinator
        solarFlare.uiDelegate = context.coordinator
        solarFlare.backgroundColor = UIColor.systemBackground
        solarFlare.scrollView.backgroundColor = UIColor(red: 0.11, green: 0.13, blue: 0.19, alpha: 1)
        solarFlare.isOpaque = false
        
        context.coordinator.buriedBoxWood(for: solarFlare)
        
        solarFlare.load(cricketChirpInside)
        webViewModel.webView = solarFlare
        return solarFlare
    }
    
    func updateUIView(_ auroraBorealisColor: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(moonHaloRing: nil, webViewModel: self.webViewModel)
    }
    
    final class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var newMoonIntent: CitrineGoldSun
        let moonHaloRing: ((_ navigationAction: TurquoiseSkyStone.NavigationAction) -> Void)?
        private var themeObservation_1: NSKeyValueObservation?
        
        init(moonHaloRing: ((_ navigationAction: TurquoiseSkyStone.NavigationAction) -> Void)?, webViewModel: CitrineGoldSun) {
            self.moonHaloRing = moonHaloRing
            self.newMoonIntent = webViewModel
            super.init()
        }
        
        func buriedBoxWood(for webView: WKWebView) {
            if #available(iOS 15.0, *) {
                themeObservation_1 = webView.observe(\.themeColor, options: [.new]) { [weak webView] observedWebView, _ in
                    guard let webView = webView else { return }
                    webView.backgroundColor = observedWebView.themeColor ?? .black
                }
            }
        }
    }
}
