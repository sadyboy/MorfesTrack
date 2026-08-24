import UIKit

final class ProfileViewController: UIViewController {

    private let engine  = CompetitiveProgressEngine()
    private let tracker = CompetitiveStreakTracker()

    // MARK: — UI

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

    // MARK: — Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "Profile"
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        rebuildContent()
    }

    // MARK: — Layout

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentStack)
        NSLayoutConstraint.activate(scrollView.edges(to: view) + [
            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: PawKit.Spacing.m),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: PawKit.Spacing.m),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -PawKit.Spacing.m),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -PawKit.Spacing.xl),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -PawKit.Spacing.m * 2),
        ])
    }

    private func rebuildContent() {
        contentStack.arrangedSubviews.forEach { $0.removeFromSuperview() }

        let xp      = UserDefaults.standard.integer(forKey: "earnedXP")
        let level   = UserDefaults.standard.integer(forKey: "levelNumber")
        let streak  = UserDefaults.standard.integer(forKey: "streakCount")
        let name    = UserDefaults.standard.string(forKey: "userName") ?? "Aquascaper"
        let lessons = UserDefaults.standard.stringArray(forKey: "completedLessonIDs") ?? []

        // Avatar card
        contentStack.addArrangedSubview(buildAvatarCard(name: name, level: level, title: engine.titleFor(level: level)))

        // Stats row
        contentStack.addArrangedSubview(buildStatsRow(xp: xp, streak: streak, lessons: lessons.count))

        // XP progress card
        contentStack.addArrangedSubview(buildXPCard(xp: xp, level: level))

        // Achievements header
        contentStack.addArrangedSubview(UILabel.pawLabel(
            text: "Achievements", font: PawKit.Font.title(17), color: .white
        ))

        // Achievement cards
        let context = CompetitiveAchievementVault.EvaluationContext(
            totalXP: xp, level: level, streak: streak,
            lessonsCompleted: lessons.count,
            questionsAnswered: UserDefaults.standard.integer(forKey: "totalQuestionsAnswered"),
            perfectQuiz: UserDefaults.standard.bool(forKey: "hasPerfectQuiz"),
            allLessonsComplete: lessons.count >= CompetitiveLessonLibrary.allLessons.count,
            unlockedIDs: Set(UserDefaults.standard.stringArray(forKey: "unlockedAchievementIDs") ?? [])
        )
        let vault   = CompetitiveAchievementVault()
        let unlocked = vault.evaluate(context: context)
        let unlockedIDs = context.unlockedIDs.union(unlocked.map { $0.id })

        for achievement in CompetitiveAchievementVault.all {
            let isUnlocked = unlockedIDs.contains(achievement.id)
            contentStack.addArrangedSubview(buildAchievementRow(achievement: achievement, isUnlocked: isUnlocked))
        }
    }

    // MARK: — Card Builders

    private func buildAvatarCard(name: String, level: Int, title: String) -> UIView {
        let card = PawCardView()
        card.translatesAutoresizingMaskIntoConstraints = false

        let config = UIImage.SymbolConfiguration(pointSize: 44, weight: .thin)
        let avatarIV = UIImageView(image: UIImage(systemName: "person.circle.fill", withConfiguration: config))
        avatarIV.translatesAutoresizingMaskIntoConstraints = false
        avatarIV.tintColor = PawKit.leaf

        let nameLbl  = UILabel.pawLabel(text: name,  font: PawKit.Font.hero(22),  color: .white)
        let titleLbl = UILabel.pawLabel(text: title, font: PawKit.Font.body(14),  color: PawKit.mist)
        let lvlLbl   = UILabel.pawLabel(text: "Level \(level)", font: PawKit.Font.mono(13), color: PawKit.amber)

        [avatarIV, nameLbl, titleLbl, lvlLbl].forEach { card.addSubview($0) }
        NSLayoutConstraint.activate([
            avatarIV.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.l),
            avatarIV.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.l),
            avatarIV.widthAnchor.constraint(equalToConstant: 56),
            avatarIV.heightAnchor.constraint(equalToConstant: 56),
            avatarIV.bottomAnchor.constraint(lessThanOrEqualTo: card.bottomAnchor, constant: -PawKit.Spacing.l),

            nameLbl.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.l),
            nameLbl.leadingAnchor.constraint(equalTo: avatarIV.trailingAnchor, constant: PawKit.Spacing.m),
            nameLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.m),

            titleLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: 4),
            titleLbl.leadingAnchor.constraint(equalTo: avatarIV.trailingAnchor, constant: PawKit.Spacing.m),

            lvlLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 4),
            lvlLbl.leadingAnchor.constraint(equalTo: avatarIV.trailingAnchor, constant: PawKit.Spacing.m),
            lvlLbl.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.l),
        ])
        return card
    }

    private func buildStatsRow(xp: Int, streak: Int, lessons: Int) -> UIView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis         = .horizontal
        stack.distribution = .fillEqually
        stack.spacing      = PawKit.Spacing.m

        stack.addArrangedSubview(statTile(value: "\(xp)", label: "Total XP",   color: PawKit.amber))
        stack.addArrangedSubview(statTile(value: "\(streak)", label: "Streak", color: PawKit.coral))
        stack.addArrangedSubview(statTile(value: "\(lessons)", label: "Lessons", color: PawKit.leaf))
        return stack
    }

    private func statTile(value: String, label: String, color: UIColor) -> UIView {
        let card = PawCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        let valLbl = UILabel.pawLabel(text: value, font: PawKit.Font.hero(24), color: color, alignment: .center)
        let lbl    = UILabel.pawLabel(text: label,  font: PawKit.Font.body(12), color: PawKit.mist, alignment: .center)
        [valLbl, lbl].forEach { card.addSubview($0) }
        NSLayoutConstraint.activate([
            valLbl.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.m),
            valLbl.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            lbl.topAnchor.constraint(equalTo: valLbl.bottomAnchor, constant: 4),
            lbl.centerXAnchor.constraint(equalTo: card.centerXAnchor),
            lbl.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.m),
        ])
        return card
    }

    private func buildXPCard(xp: Int, level: Int) -> UIView {
        let card = PawCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        let bar  = XPBarView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        let lbl  = UILabel.pawLabel(
            text: "\(xp) XP · Next level: \(engine.xpForNextLevel(currentXP: xp)) XP",
            font: PawKit.Font.mono(12), color: PawKit.mist
        )
        card.addSubview(bar)
        card.addSubview(lbl)
        NSLayoutConstraint.activate([
            bar.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.m),
            bar.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.m),
            bar.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.m),
            bar.heightAnchor.constraint(equalToConstant: 8),
            lbl.topAnchor.constraint(equalTo: bar.bottomAnchor, constant: 8),
            lbl.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.m),
            lbl.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.m),
        ])
        bar.setProgress(engine.progressFraction(currentXP: xp), animated: true)
        return card
    }

    private func buildAchievementRow(achievement: Achievement, isUnlocked: Bool) -> UIView {
        let card = PawCardView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.alpha = isUnlocked ? 1.0 : 0.4

        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        let icon = UIImageView(image: UIImage(systemName: achievement.icon, withConfiguration: config))
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.tintColor = isUnlocked ? PawKit.gold : PawKit.silverGray

        let titleLbl = UILabel.pawLabel(text: achievement.title, font: PawKit.Font.title(14), color: .white)
        let descLbl  = UILabel.pawLabel(text: achievement.description, font: PawKit.Font.body(12), color: PawKit.mist, lines: 2)
        let xpLbl    = UILabel.pawLabel(text: "+\(achievement.xpReward) XP", font: PawKit.Font.mono(12), color: PawKit.amber)

        let lockIcon = UIImageView(image: UIImage(systemName: isUnlocked ? "checkmark.circle.fill" : "lock.fill",
                                                   withConfiguration: UIImage.SymbolConfiguration(pointSize: 14)))
        lockIcon.translatesAutoresizingMaskIntoConstraints = false
        lockIcon.tintColor = isUnlocked ? PawKit.leaf : PawKit.silverGray

        [icon, titleLbl, descLbl, xpLbl, lockIcon].forEach { card.addSubview($0) }
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            icon.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.m),
            icon.widthAnchor.constraint(equalToConstant: 28),
            icon.heightAnchor.constraint(equalToConstant: 28),

            titleLbl.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.m),
            titleLbl.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: PawKit.Spacing.m),
            titleLbl.trailingAnchor.constraint(equalTo: lockIcon.leadingAnchor, constant: -PawKit.Spacing.s),

            descLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 2),
            descLbl.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: PawKit.Spacing.m),
            descLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.m),

            xpLbl.topAnchor.constraint(equalTo: descLbl.bottomAnchor, constant: 4),
            xpLbl.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: PawKit.Spacing.m),
            xpLbl.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.m),

            lockIcon.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            lockIcon.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.m),
        ])
        return card
    }
}
