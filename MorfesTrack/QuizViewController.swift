import UIKit

final class QuizViewController: UIViewController {

    private var session: QuizSession?
    private var selectedIndex: Int? = nil

    // MARK: — Top accent stripe
    private let accentStripe: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = PawKit.amber
        return v
    }()

    // MARK: — Progress
    private let progressTrack: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(hex: "#050A07")
        v.layer.cornerRadius = 3
        v.layer.borderWidth  = 1
        v.layer.borderColor  = UIColor(hex: "#1A3022").cgColor
        v.clipsToBounds = true
        return v
    }()
    private let progressFill: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = PawKit.amber
        v.layer.cornerRadius = 3
        return v
    }()
    private var progressFillWidth: NSLayoutConstraint?
    private let progressLabel = UILabel.pawLabel(
        font: PawKit.Font.mono(11), color: PawKit.mist, alignment: .right
    )

    // MARK: — Question card
    private let questionCard = PawCardView()
    private let difficultyChip: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = PawKit.Font.mono(10)
        l.layer.cornerRadius = PawKit.Radius.small
        l.layer.borderWidth  = 1
        l.clipsToBounds = true
        l.textAlignment = .center
        return l
    }()
    private let questionLabel = UILabel.pawLabel(
        font: PawKit.Font.title(17), color: .white,
        alignment: .left, lines: 0
    )

    // MARK: — Options
    private let optionsStack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = 10
        return s
    }()

    // MARK: — Explanation card
    private let explanationCard = PawCardView()
    private let explanationLabel = UILabel.pawLabel(
        font: PawKit.Font.body(14), color: PawKit.mist,
        alignment: .left, lines: 0
    )
    private let xpEarnedLabel = UILabel.pawLabel(
        font: PawKit.Font.mono(13), color: PawKit.amber, alignment: .right
    )

    // MARK: — Next button
    private let nextButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "NEXT  →"
        config.baseBackgroundColor = PawKit.amber
        config.baseForegroundColor = UIColor(hex: "#060D08")
        config.cornerStyle = .fixed
        config.background.cornerRadius = PawKit.Radius.button
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { a in
            var b = a; b.font = PawKit.Font.mono(15); return b
        }
        let b = UIButton(configuration: config)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.isHidden = true
        return b
    }()

    // MARK: — Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "Challenge"
        setupLayout()
        startNewSession()
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
    }

    // MARK: — Layout

    private func setupLayout() {
        // Top amber stripe
        view.addSubview(accentStripe)
        NSLayoutConstraint.activate([
            accentStripe.topAnchor.constraint(equalTo: view.topAnchor),
            accentStripe.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accentStripe.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accentStripe.heightAnchor.constraint(equalToConstant: 3),
        ])

        // Progress track + fill
        progressTrack.addSubview(progressFill)
        progressFillWidth = progressFill.widthAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            progressFill.leadingAnchor.constraint(equalTo: progressTrack.leadingAnchor),
            progressFill.topAnchor.constraint(equalTo: progressTrack.topAnchor),
            progressFill.bottomAnchor.constraint(equalTo: progressTrack.bottomAnchor),
            progressFillWidth!,
        ])

        let progressRow = UIStackView(arrangedSubviews: [progressTrack, progressLabel])
        progressRow.translatesAutoresizingMaskIntoConstraints = false
        progressRow.spacing = PawKit.Spacing.s
        progressRow.alignment = .center

        // Explanation card
        explanationCard.translatesAutoresizingMaskIntoConstraints = false
        explanationCard.isHidden = true
        [explanationLabel, xpEarnedLabel].forEach { explanationCard.addSubview($0) }

        // Question card
        questionCard.translatesAutoresizingMaskIntoConstraints = false
        [difficultyChip, questionLabel].forEach { questionCard.addSubview($0) }

        [progressRow, questionCard, optionsStack, explanationCard, nextButton].forEach {
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            progressRow.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PawKit.Spacing.m),
            progressRow.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            progressRow.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),
            progressTrack.heightAnchor.constraint(equalToConstant: 6),
            progressLabel.widthAnchor.constraint(equalToConstant: 50),

            questionCard.topAnchor.constraint(equalTo: progressRow.bottomAnchor, constant: PawKit.Spacing.m),
            questionCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            questionCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),

            difficultyChip.topAnchor.constraint(equalTo: questionCard.topAnchor, constant: PawKit.Spacing.m),
            difficultyChip.leadingAnchor.constraint(equalTo: questionCard.leadingAnchor, constant: PawKit.Spacing.m),
            difficultyChip.heightAnchor.constraint(equalToConstant: 22),

            questionLabel.topAnchor.constraint(equalTo: difficultyChip.bottomAnchor, constant: PawKit.Spacing.s),
            questionLabel.leadingAnchor.constraint(equalTo: questionCard.leadingAnchor, constant: PawKit.Spacing.m),
            questionLabel.trailingAnchor.constraint(equalTo: questionCard.trailingAnchor, constant: -PawKit.Spacing.m),
            questionLabel.bottomAnchor.constraint(equalTo: questionCard.bottomAnchor, constant: -PawKit.Spacing.m),

            optionsStack.topAnchor.constraint(equalTo: questionCard.bottomAnchor, constant: PawKit.Spacing.m),
            optionsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            optionsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),

            explanationCard.topAnchor.constraint(equalTo: optionsStack.bottomAnchor, constant: PawKit.Spacing.m),
            explanationCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            explanationCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),

            explanationLabel.topAnchor.constraint(equalTo: explanationCard.topAnchor, constant: PawKit.Spacing.m),
            explanationLabel.leadingAnchor.constraint(equalTo: explanationCard.leadingAnchor, constant: PawKit.Spacing.m),
            explanationLabel.trailingAnchor.constraint(equalTo: explanationCard.trailingAnchor, constant: -PawKit.Spacing.m),

            xpEarnedLabel.topAnchor.constraint(equalTo: explanationLabel.bottomAnchor, constant: PawKit.Spacing.s),
            xpEarnedLabel.trailingAnchor.constraint(equalTo: explanationCard.trailingAnchor, constant: -PawKit.Spacing.m),
            xpEarnedLabel.bottomAnchor.constraint(equalTo: explanationCard.bottomAnchor, constant: -PawKit.Spacing.m),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -PawKit.Spacing.m),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),
            nextButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }

    // MARK: — Session

    private func startNewSession() {
        let completed = Set(UserDefaults.standard.stringArray(forKey: "completedQuestionIDs") ?? [])
        session = CompetitiveQuestionLibrary.dailyQuiz(excluding: completed)
        selectedIndex = nil
        renderCurrent()
    }

    private func renderCurrent() {
        guard let session, let q = session.currentQuestion else {
            showSummary()
            return
        }

        let total   = session.questions.count
        let current = session.currentIndex + 1

        // Animate progress fill
        layoutIfNeeded()
        let fraction = CGFloat(current) / CGFloat(total)
        progressFill.layoutIfNeeded()
        progressFillWidth?.constant = progressTrack.bounds.width * fraction
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut) {
            self.progressTrack.layoutIfNeeded()
        }
        progressLabel.text = "\(current)/\(total)"

        // Difficulty chip
        switch q.difficulty {
        case .beginner:
            difficultyChip.text       = "  BEGINNER  "
            difficultyChip.textColor  = PawKit.leaf
            difficultyChip.layer.borderColor = PawKit.leaf.withAlphaComponent(0.5).cgColor
            difficultyChip.backgroundColor   = PawKit.leaf.withAlphaComponent(0.08)
        case .intermediate:
            difficultyChip.text       = "  INTERMEDIATE  "
            difficultyChip.textColor  = PawKit.amber
            difficultyChip.layer.borderColor = PawKit.amber.withAlphaComponent(0.5).cgColor
            difficultyChip.backgroundColor   = PawKit.amber.withAlphaComponent(0.08)
        case .expert:
            difficultyChip.text       = "  EXPERT  "
            difficultyChip.textColor  = PawKit.coral
            difficultyChip.layer.borderColor = PawKit.coral.withAlphaComponent(0.5).cgColor
            difficultyChip.backgroundColor   = PawKit.coral.withAlphaComponent(0.08)
        }

        questionLabel.text = q.question

        optionsStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let letters = ["A", "B", "C", "D"]
        for (i, option) in q.options.enumerated() {
            optionsStack.addArrangedSubview(makeOptionRow(letter: letters[i], title: option, index: i))
        }

        explanationCard.isHidden = true
        nextButton.isHidden      = true
        selectedIndex            = nil
    }

    private func makeOptionRow(letter: String, title: String, index: Int) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor  = UIColor(hex: "#08110C")
        container.layer.cornerRadius = PawKit.Radius.button
        container.layer.borderWidth  = 1
        container.layer.borderColor  = UIColor(hex: "#1E3828").cgColor
        container.tag = index

        // Letter badge
        let badge = UILabel()
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.text          = letter
        badge.font          = PawKit.Font.mono(12)
        badge.textColor     = PawKit.amber
        badge.textAlignment = .center
        badge.backgroundColor  = UIColor(hex: "#0D1A10")
        badge.layer.cornerRadius = 6
        badge.layer.borderWidth  = 1
        badge.layer.borderColor  = PawKit.amber.withAlphaComponent(0.3).cgColor
        badge.clipsToBounds = true

        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text          = title
        textLabel.font          = PawKit.Font.body(15)
        textLabel.textColor     = .white
        textLabel.numberOfLines = 0

        container.addSubview(badge)
        container.addSubview(textLabel)

        NSLayoutConstraint.activate([
            badge.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            badge.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            badge.widthAnchor.constraint(equalToConstant: 28),
            badge.heightAnchor.constraint(equalToConstant: 28),

            textLabel.leadingAnchor.constraint(equalTo: badge.trailingAnchor, constant: 12),
            textLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),
            textLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 14),
            textLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -14),
        ])

        let tap = UITapGestureRecognizer(target: self, action: #selector(optionTapped(_:)))
        container.addGestureRecognizer(tap)
        container.isUserInteractionEnabled = true

        return container
    }

    @objc private func optionTapped(_ sender: UITapGestureRecognizer) {
        guard selectedIndex == nil, var session else { return }
        guard let container = sender.view else { return }
        let chosen = container.tag
        selectedIndex = chosen
        session.answer(chosen)
        self.session = session

        guard let q = session.currentQuestion else { return }
        let correct = q.correctIndex
        PawKit.haptics.press()

        // Visual feedback on each option row
        for view in optionsStack.arrangedSubviews {
            let i = view.tag
            let textLbl = view.subviews.compactMap { $0 as? UILabel }.last
            let badge   = view.subviews.compactMap { $0 as? UILabel }.first

            if i == correct {
                view.layer.borderColor  = PawKit.leaf.cgColor
                view.backgroundColor    = PawKit.leaf.withAlphaComponent(0.08)
                textLbl?.textColor = PawKit.leaf
                badge?.textColor   = PawKit.leaf
                badge?.layer.borderColor = PawKit.leaf.withAlphaComponent(0.5).cgColor
            } else if i == chosen {
                view.layer.borderColor  = PawKit.coral.cgColor
                view.backgroundColor    = PawKit.coral.withAlphaComponent(0.08)
                textLbl?.textColor = PawKit.coral
                badge?.textColor   = PawKit.coral
                badge?.layer.borderColor = PawKit.coral.withAlphaComponent(0.5).cgColor
            } else {
                view.alpha = 0.4
            }
            (view as? UIControl)?.isEnabled = false
            view.isUserInteractionEnabled = false
        }

        // Explanation
        explanationLabel.text = q.explanation
        let earned = chosen == correct ? q.difficulty.xpReward : 0
        xpEarnedLabel.text = earned > 0 ? "+\(earned) XP" : "No XP — review the explanation"
        xpEarnedLabel.textColor = earned > 0 ? PawKit.amber : PawKit.coral

        if earned > 0 { PawKit.haptics.success() } else { PawKit.haptics.error() }

        UIView.animate(withDuration: 0.3) {
            self.explanationCard.isHidden = false
        }
        nextButton.isHidden = false

        if earned > 0 {
            let current = UserDefaults.standard.integer(forKey: "earnedXP")
            UserDefaults.standard.set(current + earned, forKey: "earnedXP")
        }
    }

    @objc private func nextTapped() {
        PawKit.haptics.tap()
        session?.advance()
        renderCurrent()
    }

    private func showSummary() {
        guard let session else { return }
        let vc = QuizSummaryViewController(session: session)
        vc.onRestart = { [weak self] in self?.startNewSession() }
        navigationController?.pushViewController(vc, animated: true)
    }

    private func layoutIfNeeded() {
        view.layoutIfNeeded()
    }
}

// MARK: — Quiz Summary

final class QuizSummaryViewController: UIViewController {

    private let session: QuizSession
    var onRestart: (() -> Void)?

    init(session: QuizSession) {
        self.session = session
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "Results"
        navigationItem.hidesBackButton = true
        buildLayout()
    }

    private func buildLayout() {
        // Accent stripe
        let stripe = UIView()
        stripe.translatesAutoresizingMaskIntoConstraints = false
        stripe.backgroundColor = PawKit.amber
        view.addSubview(stripe)

        // Grade
        let grade = letterGrade()
        let gradeLabel = UILabel.pawLabel(text: grade, font: PawKit.Font.hero(72), color: gradeColor(), alignment: .center)

        let scoreLbl = UILabel.pawLabel(
            text: "\(session.score)/\(session.questions.count)",
            font: PawKit.Font.mono(36), color: .white, alignment: .center
        )
        let accLbl = UILabel.pawLabel(
            text: "\(Int(session.accuracy * 100))% accuracy",
            font: PawKit.Font.body(16), color: PawKit.mist, alignment: .center
        )
        let xpLbl = UILabel.pawLabel(
            text: "+\(session.totalXP) XP",
            font: PawKit.Font.mono(20), color: PawKit.amber, alignment: .center
        )

        let card = PawCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        [gradeLabel, scoreLbl, accLbl, xpLbl].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            card.addSubview($0)
        }

        var btnConfig = UIButton.Configuration.filled()
        btnConfig.title = "NEW QUIZ"
        btnConfig.baseBackgroundColor = PawKit.amber
        btnConfig.baseForegroundColor = UIColor(hex: "#060D08")
        btnConfig.cornerStyle = .fixed
        btnConfig.background.cornerRadius = PawKit.Radius.button
        btnConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { a in
            var b = a; b.font = PawKit.Font.mono(15); return b
        }
        let restartBtn = UIButton(configuration: btnConfig)
        restartBtn.translatesAutoresizingMaskIntoConstraints = false
        restartBtn.addTarget(self, action: #selector(restart), for: .touchUpInside)

        view.addSubview(card)
        view.addSubview(restartBtn)

        NSLayoutConstraint.activate([
            stripe.topAnchor.constraint(equalTo: view.topAnchor),
            stripe.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stripe.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stripe.heightAnchor.constraint(equalToConstant: 3),

            card.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            card.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.xl),
            card.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.xl),

            gradeLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.xl),
            gradeLabel.centerXAnchor.constraint(equalTo: card.centerXAnchor),

            scoreLbl.topAnchor.constraint(equalTo: gradeLabel.bottomAnchor, constant: PawKit.Spacing.s),
            scoreLbl.centerXAnchor.constraint(equalTo: card.centerXAnchor),

            accLbl.topAnchor.constraint(equalTo: scoreLbl.bottomAnchor, constant: PawKit.Spacing.s),
            accLbl.centerXAnchor.constraint(equalTo: card.centerXAnchor),

            xpLbl.topAnchor.constraint(equalTo: accLbl.bottomAnchor, constant: PawKit.Spacing.m),
            xpLbl.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            xpLbl.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.xl),

            restartBtn.topAnchor.constraint(equalTo: card.bottomAnchor, constant: PawKit.Spacing.xl),
            restartBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            restartBtn.widthAnchor.constraint(equalToConstant: 220),
            restartBtn.heightAnchor.constraint(equalToConstant: 52),
        ])
    }

    private func letterGrade() -> String {
        switch session.accuracy {
        case 1.0:         return "S"
        case 0.8..<1.0:  return "A"
        case 0.6..<0.8:  return "B"
        case 0.4..<0.6:  return "C"
        default:          return "D"
        }
    }

    private func gradeColor() -> UIColor {
        switch session.accuracy {
        case 1.0:         return PawKit.gold
        case 0.8..<1.0:  return PawKit.leaf
        case 0.6..<0.8:  return PawKit.amber
        case 0.4..<0.6:  return PawKit.coral
        default:          return PawKit.coral
        }
    }

    @objc private func restart() {
        PawKit.haptics.tap()
        navigationController?.popToRootViewController(animated: true)
        onRestart?()
    }
}
