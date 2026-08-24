import UIKit
import SwiftUI

// ═══════════════════════════════════════════════════════════
// PawKit — Blingox Luck Design System
// Theme: Gothic Competitive Aquascaping
// Palette: Obsidian blacks · Moss greens · Antique amber
// ═══════════════════════════════════════════════════════════

enum PawKit {

    // MARK: — Colors (UIColor)  — Gothic aquascaping palette
    static let forestDeep   = UIColor(hex: "#06100A")   // near-black obsidian
    static let forestDark   = UIColor(hex: "#0B1810")   // void forest
    static let forestMid    = UIColor(hex: "#1A3222")   // dark moss
    static let leaf         = UIColor(hex: "#5EC485")   // cold moss green
    static let mist         = UIColor(hex: "#7A9C82")   // dim sage
    static let amber        = UIColor(hex: "#C47C1A")   // antique amber
    static let coral        = UIColor(hex: "#B84E3A")   // dark ember
    static let cream        = UIColor(hex: "#C8BFA8")   // gothic parchment

    // Gothic accents
    static let sovietRed    = UIColor(hex: "#8B1A1A")
    static let ink          = UIColor(hex: "#030705")
    static let chalk        = UIColor.white

    // Semantic
    static let positive     = UIColor(hex: "#5EC485")
    static let negative     = UIColor(hex: "#B84E3A")
    static let gold         = UIColor(hex: "#C4A030")   // antique gold
    static let silverGray   = UIColor(hex: "#5A6E60")   // aged silver

    // MARK: — SwiftUI Colors
    static let cForestDeep  = Color(forestDeep)
    static let cForestDark  = Color(forestDark)
    static let cForestMid   = Color(forestMid)
    static let cLeaf        = Color(leaf)
    static let cMist        = Color(mist)
    static let cAmber       = Color(amber)
    static let cCoral       = Color(coral)
    static let cGold        = Color(gold)

    // MARK: — Typography
    enum Font {
        static func hero(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .bold)
        }
        static func title(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .semibold)
        }
        static func body(_ size: CGFloat) -> UIFont {
            UIFont.systemFont(ofSize: size, weight: .regular)
        }
        static func mono(_ size: CGFloat) -> UIFont {
            UIFont.monospacedDigitSystemFont(ofSize: size, weight: .medium)
        }
        static func rounded(_ size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
            let descriptor = UIFont.systemFont(ofSize: size, weight: weight)
                .fontDescriptor.withDesign(.rounded) ?? UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor
            return UIFont(descriptor: descriptor, size: size)
        }
    }

    // SwiftUI font helpers
    static func swiftFont(size: CGFloat, weight: SwiftUI.Font.Weight = .regular) -> SwiftUI.Font {
        .system(size: size, weight: weight, design: .rounded)
    }
    static func monoFont(size: CGFloat) -> SwiftUI.Font {
        .system(size: size, weight: .medium).monospacedDigit()
    }

    // MARK: — Spacing
    enum Spacing {
        static let xs: CGFloat = 4
        static let s:  CGFloat = 8
        static let m:  CGFloat = 16
        static let l:  CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 48
    }

    // MARK: — Corner Radii  (more architectural, less pill-shaped)
    enum Radius {
        static let card:   CGFloat = 14
        static let chip:   CGFloat = 6
        static let button: CGFloat = 10
        static let small:  CGFloat = 4
    }

    // MARK: — Gradients
    static func forestGradient() -> [CGColor] {
        [forestDeep.cgColor, forestDark.cgColor]
    }
    static func cardGradient() -> [CGColor] {
        [forestMid.cgColor, forestDark.cgColor]
    }
    static func amberGradient() -> [CGColor] {
        [amber.cgColor, coral.cgColor]
    }

    // MARK: — Shadows  (gothic: green glow + deep black drop)
    static func applyShadow(to layer: CALayer,
                             color: UIColor = UIColor(hex: "#5EC485"),
                             opacity: Float = 0.10,
                             radius: CGFloat = 14,
                             offset: CGSize = CGSize(width: 0, height: 2)) {
        layer.shadowColor   = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius  = radius
        layer.shadowOffset  = offset
        layer.masksToBounds = false
    }

    // MARK: — Haptics (singleton wrapper)
    static let haptics = HapticManager.shared
}

// MARK: — UIColor Hex Init
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8)  / 255
        let b = CGFloat( rgb & 0x0000FF)         / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

// MARK: — HapticManager
final class HapticManager {
    static let shared = HapticManager()
    private init() {}

    private let light  = UIImpactFeedbackGenerator(style: .light)
    private let medium = UIImpactFeedbackGenerator(style: .medium)
    private let heavy  = UIImpactFeedbackGenerator(style: .heavy)
    private let rigid  = UIImpactFeedbackGenerator(style: .rigid)
    private let notif  = UINotificationFeedbackGenerator()

    func tap()        { light.impactOccurred() }
    func press()      { medium.impactOccurred() }
    func complete()   { heavy.impactOccurred() }
    func pin()        { rigid.impactOccurred() }
    func success()    { notif.notificationOccurred(.success) }
    func error()      { notif.notificationOccurred(.error) }

    func levelUpPattern() {
        medium.impactOccurred()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in self?.medium.impactOccurred() }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) { [weak self] in self?.heavy.impactOccurred() }
    }

    func sessionBegin() { heavy.impactOccurred() }
}
