import UIKit

final class LevelUpOverlayViewController: UIViewController {

    private let info: LevelInfo
    private let onDismiss: () -> Void

    init(info: LevelInfo, onDismiss: @escaping () -> Void) {
        self.info      = info
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle   = .crossDissolve
    }
    required init?(coder: NSCoder) { fatalError() }

    // MARK: — UI

    private let dimView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        return v
    }()

    private let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = PawKit.forestDark
        v.layer.cornerRadius = PawKit.Radius.card
        v.layer.masksToBounds = true
        return v
    }()

    private let crownImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 52, weight: .regular)
        let iv = UIImageView(image: UIImage(systemName: "crown.fill", withConfiguration: config))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = PawKit.gold
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let levelUpLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Level Up!"
        l.font = PawKit.Font.hero(32)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()

    private let levelTitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = PawKit.Font.title(18)
        l.textColor = PawKit.leaf
        l.textAlignment = .center
        return l
    }()

    private let abilityLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = PawKit.Font.body(14)
        l.textColor = PawKit.mist
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()

    private let continueButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Continue"
        config.baseBackgroundColor = PawKit.gold
        config.baseForegroundColor = PawKit.forestDeep
        config.cornerStyle = .fixed
        config.background.cornerRadius = PawKit.Radius.button
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrs in
            var a = attrs; a.font = PawKit.Font.title(17); return a
        }
        let b = UIButton(configuration: config)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    // MARK: — Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configure()

        continueButton.addTarget(self, action: #selector(dismiss_), for: .touchUpInside)
        dimView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss_)))

        cardView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        cardView.alpha = 0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        PawKit.haptics.levelUpPattern()
        UIView.animate(withDuration: 0.45, delay: 0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.5) {
            self.cardView.transform = .identity
            self.cardView.alpha = 1
        }
    }

    // MARK: — Setup

    private func configure() {
        levelTitleLabel.text = "Level \(info.level) — \(info.title)"
        abilityLabel.text    = info.newAbility
        abilityLabel.isHidden = info.newAbility == nil
    }

    private func setupLayout() {
        view.addSubview(dimView)
        view.addSubview(cardView)
        [crownImageView, levelUpLabel, levelTitleLabel, abilityLabel, continueButton].forEach { cardView.addSubview($0) }

        NSLayoutConstraint.activate(dimView.edges(to: view) + [
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.xl),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.xl),

            crownImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: PawKit.Spacing.xl),
            crownImageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            crownImageView.widthAnchor.constraint(equalToConstant: 64),
            crownImageView.heightAnchor.constraint(equalToConstant: 64),

            levelUpLabel.topAnchor.constraint(equalTo: crownImageView.bottomAnchor, constant: PawKit.Spacing.m),
            levelUpLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),

            levelTitleLabel.topAnchor.constraint(equalTo: levelUpLabel.bottomAnchor, constant: PawKit.Spacing.s),
            levelTitleLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            levelTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: PawKit.Spacing.m),
            levelTitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -PawKit.Spacing.m),

            abilityLabel.topAnchor.constraint(equalTo: levelTitleLabel.bottomAnchor, constant: PawKit.Spacing.m),
            abilityLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: PawKit.Spacing.l),
            abilityLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -PawKit.Spacing.l),

            continueButton.topAnchor.constraint(equalTo: abilityLabel.bottomAnchor, constant: PawKit.Spacing.l),
            continueButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: PawKit.Spacing.xl),
            continueButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -PawKit.Spacing.xl),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -PawKit.Spacing.xl),
        ])
    }

    @objc private func dismiss_() {
        PawKit.haptics.press()
        dismiss(animated: true) { self.onDismiss() }
    }
}
