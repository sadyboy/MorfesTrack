import UIKit

// MARK: — NSLayoutConstraint helpers

extension UIView {

    /// Pin all edges to another view
    func edges(to view: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
        ]
    }

    /// Pin all edges to superview safe area
    func edgesToSafeArea(of view: UIView, insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom),
        ]
    }

    func constrainSize(width: CGFloat? = nil, height: CGFloat? = nil) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if let w = width  { constraints.append(widthAnchor.constraint(equalToConstant: w)) }
        if let h = height { constraints.append(heightAnchor.constraint(equalToConstant: h)) }
        return constraints
    }

    func center(in view: UIView) -> [NSLayoutConstraint] {
        [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ]
    }

    @discardableResult
    func addSubviews(_ views: UIView...) -> Self {
        views.forEach { addSubview($0) }
        return self
    }

    func applyPawShadow() {
        PawKit.applyShadow(to: layer)
    }
}

// MARK: — UIViewController helpers

extension UIViewController {

    func presentLevelUp(info: LevelInfo, onDismiss: @escaping () -> Void) {
        let vc = LevelUpOverlayViewController(info: info, onDismiss: onDismiss)
        present(vc, animated: true)
    }

    func presentConfetti() {
        let vc = ConfettiViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle   = .crossDissolve
        present(vc, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) { [weak vc] in
            vc?.dismiss(animated: false)
        }
    }
}

// MARK: — Reusable gradient layer

final class GradientView: UIView {

    override class var layerClass: AnyClass { CAGradientLayer.self }

    private var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    convenience init(colors: [CGColor], direction: Direction = .vertical) {
        self.init(frame: .zero)
        gradientLayer.colors = colors
        switch direction {
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1)
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint   = CGPoint(x: 1, y: 0.5)
        case .diagonal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint   = CGPoint(x: 1, y: 1)
        }
    }

    enum Direction { case vertical, horizontal, diagonal }
}

// MARK: — PawKit Card View

final class PawCardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor     = UIColor(hex: "#08110C")   // deep void
        layer.cornerRadius  = PawKit.Radius.card
        layer.masksToBounds = false
        layer.borderWidth   = 1
        layer.borderColor   = UIColor(hex: "#1E3828").withAlphaComponent(0.85).cgColor
        PawKit.applyShadow(to: layer)
    }
}

// MARK: — XP Bar View

final class XPBarView: UIView {

    private let trackView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(hex: "#050A07")
        v.layer.cornerRadius = 3
        v.layer.borderWidth  = 1
        v.layer.borderColor  = UIColor(hex: "#1A3022").cgColor
        v.clipsToBounds = true
        return v
    }()

    private let fillView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = PawKit.amber
        v.layer.cornerRadius = 3
        return v
    }()

    private var fillWidthConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(trackView)
        trackView.addSubview(fillView)
        NSLayoutConstraint.activate(trackView.edges(to: self))
        NSLayoutConstraint.activate([
            fillView.leadingAnchor.constraint(equalTo: trackView.leadingAnchor),
            fillView.topAnchor.constraint(equalTo: trackView.topAnchor),
            fillView.bottomAnchor.constraint(equalTo: trackView.bottomAnchor),
        ])
        fillWidthConstraint = fillView.widthAnchor.constraint(equalToConstant: 0)
        fillWidthConstraint?.isActive = true
    }
    required init?(coder: NSCoder) { fatalError() }

    func setProgress(_ fraction: Double, animated: Bool = true) {
        layoutIfNeeded()
        let width = trackView.bounds.width * CGFloat(max(0, min(1, fraction)))
        fillWidthConstraint?.constant = width
        if animated {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
                self.layoutIfNeeded()
            }
        }
    }
}

// MARK: — Streak Badge View

final class StreakBadgeView: UIView {

    private let flameIcon: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold)
        let iv = UIImageView(image: UIImage(systemName: "flame.fill", withConfiguration: config))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = PawKit.amber
        return iv
    }()

    private let countLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = PawKit.Font.mono(14)
        l.textColor = .white
        return l
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor    = UIColor(hex: "#080F0B")
        layer.cornerRadius = PawKit.Radius.small
        layer.borderWidth  = 1
        layer.borderColor  = PawKit.amber.withAlphaComponent(0.4).cgColor
        clipsToBounds      = true
        addSubviews(flameIcon, countLabel)
        NSLayoutConstraint.activate([
            flameIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: PawKit.Spacing.s),
            flameIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.leadingAnchor.constraint(equalTo: flameIcon.trailingAnchor, constant: 4),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -PawKit.Spacing.s),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: 32),
        ])
    }
    required init?(coder: NSCoder) { fatalError() }

    func configure(streak: Int) {
        countLabel.text = "\(streak)"
        flameIcon.tintColor = streak >= 7 ? PawKit.coral : PawKit.amber
    }
}

// MARK: — UILabel factory

extension UILabel {
    static func pawLabel(text: String = "",
                         font: UIFont,
                         color: UIColor = .white,
                         alignment: NSTextAlignment = .left,
                         lines: Int = 1) -> UILabel {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text          = text
        l.font          = font
        l.textColor     = color
        l.textAlignment = alignment
        l.numberOfLines = lines
        return l
    }
}

// MARK: — NSLayoutConstraint activation shorthand used in project

extension NSLayoutConstraint {
    @discardableResult
    static func activateAll(_ constraints: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        NSLayoutConstraint.activate(constraints)
        return constraints
    }
}
