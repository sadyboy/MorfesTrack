import UIKit

final class HomeViewController: UIViewController {

    private let appState = CelestialArcState()

    // MARK: — Scroll

    private let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.showsVerticalScrollIndicator = false
        return s
    }()

    private let contentStack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = PawKit.Spacing.l
        return s
    }()

    // MARK: — Hero card

    private let heroCard  = PawCardView()
    private let waveView  = AnimatedWaveView()
    private let greetingLabel   = UILabel.pawLabel(font: PawKit.Font.body(14), color: PawKit.mist, alignment: .left)
    private let heroTitleLabel  = UILabel.pawLabel(font: PawKit.Font.hero(26), color: .white, alignment: .left, lines: 2)
    private let xpLabel         = UILabel.pawLabel(font: PawKit.Font.mono(13), color: PawKit.leaf, alignment: .left)
    private let xpBar           = XPBarView()
    private let levelChip: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = PawKit.Font.mono(11)
        l.textColor = PawKit.amber
        l.backgroundColor = UIColor(hex: "#0D1A10")
        l.layer.cornerRadius = PawKit.Radius.small
        l.layer.borderWidth  = 1
        l.layer.borderColor  = PawKit.amber.withAlphaComponent(0.45).cgColor
        l.clipsToBounds = true
        l.textAlignment = .center
        return l
    }()

    // MARK: — Tank Health card

    private let tankCard        = PawCardView()
    private let tankTitleLabel  = UILabel.pawLabel(font: PawKit.Font.mono(10), color: PawKit.amber)
    private let tankScoreLabel  = UILabel.pawLabel(font: PawKit.Font.mono(32), color: .white)
    private let tankStatusLabel = UILabel.pawLabel(font: PawKit.Font.body(13), color: PawKit.mist)
    private let tankParamLabel  = UILabel.pawLabel(font: PawKit.Font.mono(11), color: PawKit.silverGray, lines: 2)
    private let tankBar         = XPBarView()
    private let tankDateLabel   = UILabel.pawLabel(font: PawKit.Font.mono(11), color: PawKit.silverGray)

    // MARK: — Streak card

    private let streakCard      = PawCardView()
    private let streakBadge     = StreakBadgeView()
    private let streakTitleLabel = UILabel.pawLabel(text: "CURRENT STREAK", font: PawKit.Font.mono(11), color: PawKit.amber)
    private let streakSubLabel   = UILabel.pawLabel(font: PawKit.Font.body(13), color: PawKit.mist, lines: 2)
    private let multiplierLabel  = UILabel.pawLabel(font: PawKit.Font.mono(12), color: PawKit.gold)

    // MARK: — Next Mission card

    private let missionCard       = PawCardView()
    private let missionTagLabel   = UILabel.pawLabel(font: PawKit.Font.mono(10), color: PawKit.amber)
    private let missionTitleLabel = UILabel.pawLabel(font: PawKit.Font.hero(20), color: .white, alignment: .left, lines: 2)
    private let missionSubLabel   = UILabel.pawLabel(font: PawKit.Font.body(13), color: PawKit.mist, alignment: .left, lines: 2)
    private let missionMetaLabel  = UILabel.pawLabel(font: PawKit.Font.mono(12), color: PawKit.mist)
    private let missionStartButton: UIButton = {
        var cfg = UIButton.Configuration.filled()
        cfg.baseBackgroundColor     = PawKit.amber
        cfg.baseForegroundColor     = UIColor(hex: "#060D08")
        cfg.cornerStyle             = .fixed
        cfg.background.cornerRadius = PawKit.Radius.button
        cfg.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { a in
            var b = a; b.font = PawKit.Font.mono(14); return b
        }
        let btn = UIButton(configuration: cfg)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    private var missionTabIndex = 1

    // MARK: — Alt actions

    private let altRow: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.spacing = PawKit.Spacing.m
        s.distribution = .fillEqually
        return s
    }()

    // MARK: — Daily Fact card

    private let factCard       = PawCardView()
    private let factTitleLabel = UILabel.pawLabel(text: "FIELD NOTES", font: PawKit.Font.mono(10), color: PawKit.amber)
    private let factBodyLabel  = UILabel.pawLabel(font: PawKit.Font.body(14), color: PawKit.mist, lines: 0)

    // MARK: — Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "Home"
        setupLayout()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
    }

    // MARK: — Layout

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: PawKit.Spacing.m),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: PawKit.Spacing.m),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -PawKit.Spacing.m),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -PawKit.Spacing.xl),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -PawKit.Spacing.m * 2),
        ])

        buildHeroCard()
        buildTankHealthCard()
        buildStreakCard()
        buildMissionCard()
        buildAltRow()
        buildFactCard()

        contentStack.addArrangedSubview(heroCard)
        contentStack.addArrangedSubview(tankCard)
        contentStack.addArrangedSubview(streakCard)
        contentStack.addArrangedSubview(missionCard)
        contentStack.addArrangedSubview(altRow)
        contentStack.addArrangedSubview(factCard)
    }

    private func buildHeroCard() {
        heroCard.translatesAutoresizingMaskIntoConstraints = false

        // Animated wave background
        waveView.translatesAutoresizingMaskIntoConstraints = false
        heroCard.insertSubview(waveView, at: 0)
        NSLayoutConstraint.activate(waveView.edges(to: heroCard))

        [greetingLabel, heroTitleLabel, xpLabel, xpBar, levelChip].forEach { heroCard.addSubview($0) }

        NSLayoutConstraint.activate([
            heroCard.heightAnchor.constraint(greaterThanOrEqualToConstant: 160),

            greetingLabel.topAnchor.constraint(equalTo: heroCard.topAnchor, constant: PawKit.Spacing.l),
            greetingLabel.leadingAnchor.constraint(equalTo: heroCard.leadingAnchor, constant: PawKit.Spacing.l),

            levelChip.centerYAnchor.constraint(equalTo: greetingLabel.centerYAnchor),
            levelChip.trailingAnchor.constraint(equalTo: heroCard.trailingAnchor, constant: -PawKit.Spacing.l),
            levelChip.widthAnchor.constraint(greaterThanOrEqualToConstant: 70),
            levelChip.heightAnchor.constraint(equalToConstant: 22),

            heroTitleLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: PawKit.Spacing.s),
            heroTitleLabel.leadingAnchor.constraint(equalTo: heroCard.leadingAnchor, constant: PawKit.Spacing.l),
            heroTitleLabel.trailingAnchor.constraint(equalTo: heroCard.trailingAnchor, constant: -PawKit.Spacing.l),

            xpBar.topAnchor.constraint(equalTo: heroTitleLabel.bottomAnchor, constant: PawKit.Spacing.m),
            xpBar.leadingAnchor.constraint(equalTo: heroCard.leadingAnchor, constant: PawKit.Spacing.l),
            xpBar.trailingAnchor.constraint(equalTo: heroCard.trailingAnchor, constant: -PawKit.Spacing.l),
            xpBar.heightAnchor.constraint(equalToConstant: 8),

            xpLabel.topAnchor.constraint(equalTo: xpBar.bottomAnchor, constant: 6),
            xpLabel.leadingAnchor.constraint(equalTo: heroCard.leadingAnchor, constant: PawKit.Spacing.l),
            xpLabel.bottomAnchor.constraint(equalTo: heroCard.bottomAnchor, constant: -PawKit.Spacing.l),
        ])
    }

    private func buildTankHealthCard() {
        tankCard.translatesAutoresizingMaskIntoConstraints = false

        let tap = UITapGestureRecognizer(target: self, action: #selector(tankTapped))
        tankCard.addGestureRecognizer(tap)

        [tankTitleLabel, tankScoreLabel, tankStatusLabel, tankBar, tankParamLabel, tankDateLabel]
            .forEach { tankCard.addSubview($0) }

        tankBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tankTitleLabel.topAnchor.constraint(equalTo: tankCard.topAnchor, constant: PawKit.Spacing.m),
            tankTitleLabel.leadingAnchor.constraint(equalTo: tankCard.leadingAnchor, constant: PawKit.Spacing.l),

            tankScoreLabel.topAnchor.constraint(equalTo: tankTitleLabel.bottomAnchor, constant: PawKit.Spacing.s),
            tankScoreLabel.leadingAnchor.constraint(equalTo: tankCard.leadingAnchor, constant: PawKit.Spacing.l),

            tankStatusLabel.centerYAnchor.constraint(equalTo: tankScoreLabel.centerYAnchor),
            tankStatusLabel.leadingAnchor.constraint(equalTo: tankScoreLabel.trailingAnchor, constant: PawKit.Spacing.s),

            tankBar.topAnchor.constraint(equalTo: tankScoreLabel.bottomAnchor, constant: PawKit.Spacing.s),
            tankBar.leadingAnchor.constraint(equalTo: tankCard.leadingAnchor, constant: PawKit.Spacing.l),
            tankBar.trailingAnchor.constraint(equalTo: tankCard.trailingAnchor, constant: -PawKit.Spacing.l),
            tankBar.heightAnchor.constraint(equalToConstant: 6),

            tankParamLabel.topAnchor.constraint(equalTo: tankBar.bottomAnchor, constant: PawKit.Spacing.s),
            tankParamLabel.leadingAnchor.constraint(equalTo: tankCard.leadingAnchor, constant: PawKit.Spacing.l),
            tankParamLabel.trailingAnchor.constraint(equalTo: tankCard.trailingAnchor, constant: -PawKit.Spacing.l),

            tankDateLabel.topAnchor.constraint(equalTo: tankParamLabel.bottomAnchor, constant: 4),
            tankDateLabel.leadingAnchor.constraint(equalTo: tankCard.leadingAnchor, constant: PawKit.Spacing.l),
            tankDateLabel.bottomAnchor.constraint(equalTo: tankCard.bottomAnchor, constant: -PawKit.Spacing.m),
        ])
    }

    private func buildStreakCard() {
        streakCard.translatesAutoresizingMaskIntoConstraints = false
        [streakBadge, streakTitleLabel, streakSubLabel, multiplierLabel].forEach { streakCard.addSubview($0) }
        NSLayoutConstraint.activate([
            streakBadge.topAnchor.constraint(equalTo: streakCard.topAnchor, constant: PawKit.Spacing.l),
            streakBadge.leadingAnchor.constraint(equalTo: streakCard.leadingAnchor, constant: PawKit.Spacing.l),

            streakTitleLabel.centerYAnchor.constraint(equalTo: streakBadge.centerYAnchor),
            streakTitleLabel.leadingAnchor.constraint(equalTo: streakBadge.trailingAnchor, constant: PawKit.Spacing.s),

            multiplierLabel.centerYAnchor.constraint(equalTo: streakBadge.centerYAnchor),
            multiplierLabel.trailingAnchor.constraint(equalTo: streakCard.trailingAnchor, constant: -PawKit.Spacing.l),

            streakSubLabel.topAnchor.constraint(equalTo: streakBadge.bottomAnchor, constant: PawKit.Spacing.s),
            streakSubLabel.leadingAnchor.constraint(equalTo: streakCard.leadingAnchor, constant: PawKit.Spacing.l),
            streakSubLabel.trailingAnchor.constraint(equalTo: streakCard.trailingAnchor, constant: -PawKit.Spacing.l),
            streakSubLabel.bottomAnchor.constraint(equalTo: streakCard.bottomAnchor, constant: -PawKit.Spacing.l),
        ])
    }

    private func buildMissionCard() {
        missionCard.translatesAutoresizingMaskIntoConstraints = false

        // Amber gothic accent line
        let accent = UIView()
        accent.translatesAutoresizingMaskIntoConstraints = false
        accent.backgroundColor = PawKit.amber
        accent.layer.cornerRadius = 1
        missionCard.addSubview(accent)

        [missionTagLabel, missionTitleLabel, missionSubLabel, missionMetaLabel, missionStartButton]
            .forEach { missionCard.addSubview($0) }

        NSLayoutConstraint.activate([
            accent.leadingAnchor.constraint(equalTo: missionCard.leadingAnchor, constant: PawKit.Spacing.m),
            accent.topAnchor.constraint(equalTo: missionCard.topAnchor, constant: PawKit.Spacing.l),
            accent.bottomAnchor.constraint(equalTo: missionCard.bottomAnchor, constant: -PawKit.Spacing.l),
            accent.widthAnchor.constraint(equalToConstant: 3),

            missionTagLabel.topAnchor.constraint(equalTo: missionCard.topAnchor, constant: PawKit.Spacing.l),
            missionTagLabel.leadingAnchor.constraint(equalTo: accent.trailingAnchor, constant: PawKit.Spacing.m),

            missionTitleLabel.topAnchor.constraint(equalTo: missionTagLabel.bottomAnchor, constant: PawKit.Spacing.s),
            missionTitleLabel.leadingAnchor.constraint(equalTo: accent.trailingAnchor, constant: PawKit.Spacing.m),
            missionTitleLabel.trailingAnchor.constraint(equalTo: missionCard.trailingAnchor, constant: -PawKit.Spacing.l),

            missionSubLabel.topAnchor.constraint(equalTo: missionTitleLabel.bottomAnchor, constant: 6),
            missionSubLabel.leadingAnchor.constraint(equalTo: accent.trailingAnchor, constant: PawKit.Spacing.m),
            missionSubLabel.trailingAnchor.constraint(equalTo: missionCard.trailingAnchor, constant: -PawKit.Spacing.l),

            missionMetaLabel.topAnchor.constraint(equalTo: missionSubLabel.bottomAnchor, constant: PawKit.Spacing.s),
            missionMetaLabel.leadingAnchor.constraint(equalTo: accent.trailingAnchor, constant: PawKit.Spacing.m),

            missionStartButton.topAnchor.constraint(equalTo: missionMetaLabel.bottomAnchor, constant: PawKit.Spacing.m),
            missionStartButton.leadingAnchor.constraint(equalTo: accent.trailingAnchor, constant: PawKit.Spacing.m),
            missionStartButton.trailingAnchor.constraint(equalTo: missionCard.trailingAnchor, constant: -PawKit.Spacing.l),
            missionStartButton.heightAnchor.constraint(equalToConstant: 48),
            missionStartButton.bottomAnchor.constraint(equalTo: missionCard.bottomAnchor, constant: -PawKit.Spacing.l),
        ])

        missionStartButton.addTarget(self, action: #selector(missionTapped), for: .touchUpInside)
    }

    private func buildAltRow() {
        let challengeBtn = makeAltButton(title: "Challenge", icon: "bolt.circle.fill", color: PawKit.amber, tag: 2)
        let logBtn       = makeAltButton(title: "Tank Log",  icon: "drop.fill",        color: PawKit.leaf,  tag: 3)
        [challengeBtn, logBtn].forEach { altRow.addArrangedSubview($0) }
    }

    private func makeAltButton(title: String, icon: String, color: UIColor, tag: Int) -> UIButton {
        var cfg = UIButton.Configuration.tinted()
        cfg.title = title
        cfg.image = UIImage(systemName: icon, withConfiguration:
            UIImage.SymbolConfiguration(pointSize: 14, weight: .semibold))
        cfg.imagePlacement = .leading
        cfg.imagePadding   = PawKit.Spacing.s
        cfg.baseBackgroundColor = PawKit.forestDark
        cfg.baseForegroundColor = color
        cfg.cornerStyle    = .fixed
        cfg.background.cornerRadius = PawKit.Radius.button
        cfg.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { a in
            var b = a; b.font = PawKit.Font.body(14); return b
        }
        let btn = UIButton(configuration: cfg)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.heightAnchor.constraint(equalToConstant: 48).isActive = true
        btn.tag = tag
        btn.addTarget(self, action: #selector(altTapped(_:)), for: .touchUpInside)
        return btn
    }

    private func buildFactCard() {
        factCard.translatesAutoresizingMaskIntoConstraints = false
        [factTitleLabel, factBodyLabel].forEach { factCard.addSubview($0) }
        NSLayoutConstraint.activate([
            factTitleLabel.topAnchor.constraint(equalTo: factCard.topAnchor, constant: PawKit.Spacing.l),
            factTitleLabel.leadingAnchor.constraint(equalTo: factCard.leadingAnchor, constant: PawKit.Spacing.l),

            factBodyLabel.topAnchor.constraint(equalTo: factTitleLabel.bottomAnchor, constant: PawKit.Spacing.s),
            factBodyLabel.leadingAnchor.constraint(equalTo: factCard.leadingAnchor, constant: PawKit.Spacing.l),
            factBodyLabel.trailingAnchor.constraint(equalTo: factCard.trailingAnchor, constant: -PawKit.Spacing.l),
            factBodyLabel.bottomAnchor.constraint(equalTo: factCard.bottomAnchor, constant: -PawKit.Spacing.l),
        ])
    }

    // MARK: — Configure

    private func configure() {
        let name   = UserDefaults.standard.string(forKey: "userName") ?? "Aquascaper"
        let xp     = UserDefaults.standard.integer(forKey: "earnedXP")
        let level  = UserDefaults.standard.integer(forKey: "levelNumber")
        let streak = UserDefaults.standard.integer(forKey: "streakCount")
        let engine  = CompetitiveProgressEngine()
        let tracker = CompetitiveStreakTracker()

        greetingLabel.text  = "Welcome back, \(name)"
        heroTitleLabel.text = engine.titleFor(level: level)
        levelChip.text      = "  Lv.\(level)  "
        xpLabel.text        = "\(xp) XP · Next: \(engine.xpForNextLevel(currentXP: xp)) XP"
        xpBar.setProgress(engine.progressFraction(currentXP: xp), animated: true)

        streakBadge.configure(streak: streak)
        let m = tracker.xpMultiplier()
        multiplierLabel.text = m > 1.0 ? "×\(String(format: "%.2g", m)) XP" : ""
        streakSubLabel.text = streak == 0
            ? "Start a streak today — complete any activity."
            : "\(streak) day\(streak == 1 ? "" : "s") in a row. Keep it going!"

        configureTankHealth()
        configureMissionCard()

        let fact = CompetitiveFactVault.facts.randomElement() ?? ""
        factBodyLabel.text = fact.count > 180 ? String(fact.prefix(180)) + "…" : fact
    }

    private func configureTankHealth() {
        let result = TankHealth.evaluate()

        tankTitleLabel.text  = "── TANK HEALTH ──"
        tankScoreLabel.text  = result.score > 0 ? "\(result.score)%" : "—"
        tankScoreLabel.textColor  = result.color
        tankStatusLabel.text = result.status
        tankStatusLabel.textColor = result.color
        tankParamLabel.text  = result.summary
        tankBar.setProgress(Double(result.score) / 100.0, animated: true)

        if let date = result.date {
            let fmt = DateFormatter()
            fmt.dateStyle = .short
            fmt.timeStyle = .short
            tankDateLabel.text = "Last logged: \(fmt.string(from: date))"
        } else {
            tankDateLabel.text = "Tap to log your first water reading →"
        }
    }

    private func configureMissionCard() {
        if let lesson = nextLesson() {
            missionTagLabel.text   = "NEXT LESSON · \(lesson.id)"
            missionTitleLabel.text = lesson.title
            missionSubLabel.text   = lesson.subtitle
            missionMetaLabel.text  = "⏱ \(lesson.estimatedMinutes) min  ·  +\(lesson.xpReward) XP"
            missionStartButton.configuration?.title = "Start Lesson  →"
            missionTabIndex = 1
        } else {
            missionTagLabel.text   = "ALL LESSONS COMPLETE"
            missionTitleLabel.text = "Take Today's Challenge"
            missionSubLabel.text   = "Test your knowledge with competition-style questions."
            missionMetaLabel.text  = "Earn XP · Build your streak"
            missionStartButton.configuration?.title = "Start Challenge  →"
            missionTabIndex = 2
        }
    }

    private func nextLesson() -> Lesson? {
        let done = Set(UserDefaults.standard.stringArray(forKey: "completedLessonIDs") ?? [])
        return CompetitiveLessonLibrary.allLessons.first { !done.contains($0.id) }
    }

    // MARK: — Actions

    @objc private func missionTapped() {
        PawKit.haptics.press()
        UIView.animate(withDuration: 0.08, animations: {
            self.missionCard.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }) { _ in
            UIView.animate(withDuration: 0.12) { self.missionCard.transform = .identity }
        }
        tabBarController?.selectedIndex = missionTabIndex
    }

    @objc private func tankTapped() {
        PawKit.haptics.tap()
        tabBarController?.selectedIndex = 3
    }

    @objc private func altTapped(_ sender: UIButton) {
        PawKit.haptics.tap()
        tabBarController?.selectedIndex = sender.tag
    }
}

// MARK: — Tank Health Calculator

private enum TankHealth {

    struct Result {
        let score: Int
        let status: String
        let color: UIColor
        let summary: String
        let date: Date?
    }

    static func evaluate() -> Result {
        guard let data = UserDefaults.standard.data(forKey: "waterLogEntries"),
              let entries = try? JSONDecoder().decode([WaterLogEntry].self, from: data),
              let last = entries.sorted(by: { $0.date > $1.date }).first
        else {
            return Result(score: 0, status: "No readings yet", color: PawKit.silverGray,
                          summary: "Log your first water reading to see tank health.", date: nil)
        }

        var scores: [Int] = []
        var parts: [String] = []

        func check(_ val: Double?, good: (Double) -> Bool, warn: (Double) -> Bool, label: String) {
            guard let v = val else { return }
            let s = good(v) ? 100 : (warn(v) ? 50 : 0)
            scores.append(s)
            parts.append("\(label) \(s == 100 ? "✓" : s == 50 ? "⚠" : "✗")")
        }

        check(last.ph,       good: { $0 >= 6.5 && $0 <= 7.5 }, warn: { $0 >= 6.0 && $0 <= 8.0 }, label: "pH")
        check(last.ammonia,  good: { $0 == 0 },                 warn: { $0 <= 0.25 },              label: "NH₃")
        check(last.nitrite,  good: { $0 == 0 },                 warn: { $0 <= 0.5 },               label: "NO₂")
        check(last.nitrate,  good: { $0 <= 20 },                warn: { $0 <= 40 },                label: "NO₃")
        check(last.tempC,    good: { $0 >= 22 && $0 <= 26 },    warn: { $0 >= 18 && $0 <= 30 },   label: "Temp")

        guard !scores.isEmpty else {
            return Result(score: 0, status: "No params", color: PawKit.silverGray, summary: "No parameters recorded.", date: last.date)
        }

        let avg = scores.reduce(0, +) / scores.count
        let (status, color): (String, UIColor) = avg >= 80
            ? ("Optimal", PawKit.leaf)
            : avg >= 50
            ? ("Monitor", PawKit.amber)
            : ("Action Needed", PawKit.coral)

        return Result(score: avg, status: status, color: color,
                      summary: parts.joined(separator: "   "), date: last.date)
    }
}
