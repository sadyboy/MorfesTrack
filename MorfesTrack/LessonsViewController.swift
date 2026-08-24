import UIKit

final class LessonsViewController: UIViewController {

    private let lessons = CompetitiveLessonLibrary.allLessons

    // MARK: — Progress header

    private let progressCard = PawCardView()
    private let progressTitle = UILabel.pawLabel(
        text: "Your Progress", font: PawKit.Font.title(15), color: .white
    )
    private let progressSub = UILabel.pawLabel(font: PawKit.Font.mono(12), color: PawKit.silverGray)
    private let progressBar = XPBarView()

    // MARK: — Collection

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .estimated(140))
            )
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: .init(widthDimension: .fractionalWidth(1),
                                  heightDimension: .estimated(140)),
                subitems: [item]
            )
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = PawKit.Spacing.m
            section.contentInsets = .init(top: PawKit.Spacing.m, leading: PawKit.Spacing.m,
                                          bottom: PawKit.Spacing.xl, trailing: PawKit.Spacing.m)
            return section
        }
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = PawKit.forestDeep
        cv.register(LessonCell.self, forCellWithReuseIdentifier: LessonCell.reuseID)
        cv.dataSource = self
        cv.delegate   = self
        return cv
    }()

    // MARK: — Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "Learn"
        buildProgressCard()
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: progressCard.bottomAnchor, constant: PawKit.Spacing.s),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        updateProgress()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateProgress()
        collectionView.reloadData()
    }

    // MARK: — Progress card

    private func buildProgressCard() {
        progressCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressCard)
        [progressTitle, progressSub, progressBar].forEach { progressCard.addSubview($0) }
        NSLayoutConstraint.activate([
            progressCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PawKit.Spacing.m),
            progressCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            progressCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),

            progressTitle.topAnchor.constraint(equalTo: progressCard.topAnchor, constant: PawKit.Spacing.m),
            progressTitle.leadingAnchor.constraint(equalTo: progressCard.leadingAnchor, constant: PawKit.Spacing.l),

            progressSub.centerYAnchor.constraint(equalTo: progressTitle.centerYAnchor),
            progressSub.trailingAnchor.constraint(equalTo: progressCard.trailingAnchor, constant: -PawKit.Spacing.l),

            progressBar.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: PawKit.Spacing.s),
            progressBar.leadingAnchor.constraint(equalTo: progressCard.leadingAnchor, constant: PawKit.Spacing.l),
            progressBar.trailingAnchor.constraint(equalTo: progressCard.trailingAnchor, constant: -PawKit.Spacing.l),
            progressBar.heightAnchor.constraint(equalToConstant: 6),
            progressBar.bottomAnchor.constraint(equalTo: progressCard.bottomAnchor, constant: -PawKit.Spacing.m),
        ])
    }

    private func updateProgress() {
        let done  = completedLessonIDs()
        let total = lessons.count
        let count = done.count
        progressSub.text = "\(count) / \(total)"
        progressBar.setProgress(total > 0 ? Double(count) / Double(total) : 0, animated: true)
    }
}

// MARK: — DataSource / Delegate

extension LessonsViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lessons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCell.reuseID, for: indexPath) as! LessonCell
        let done   = completedLessonIDs()
        let lesson = lessons[indexPath.item]
        let isNext = !done.contains(lesson.id) && lessons.prefix(indexPath.item).allSatisfy { done.contains($0.id) }
        cell.configure(lesson: lesson, isCompleted: done.contains(lesson.id), isNext: isNext)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PawKit.haptics.tap()
        let vc = LessonDetailViewController(lesson: lessons[indexPath.item])
        vc.onComplete = { [weak self] lessonID in
            self?.markCompleted(lessonID: lessonID)
            self?.updateProgress()
            self?.collectionView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }

    private func completedLessonIDs() -> Set<String> {
        Set(UserDefaults.standard.stringArray(forKey: "completedLessonIDs") ?? [])
    }

    private func markCompleted(lessonID: String) {
        var arr = UserDefaults.standard.stringArray(forKey: "completedLessonIDs") ?? []
        if !arr.contains(lessonID) { arr.append(lessonID) }
        UserDefaults.standard.set(arr, forKey: "completedLessonIDs")
    }
}

// MARK: — Lesson Cell

final class LessonCell: UICollectionViewCell {

    static let reuseID = "LessonCell"

    private let card        = PawCardView()
    private let accentBar   = UIView()           // left-side green bar for "next" lesson
    private let nextBadge   = UILabel()          // "NEXT UP" pill
    private let numberLabel = UILabel.pawLabel(font: PawKit.Font.mono(12), color: PawKit.leaf)
    private let titleLabel  = UILabel.pawLabel(font: PawKit.Font.title(16), color: .white, lines: 2)
    private let subLabel    = UILabel.pawLabel(font: PawKit.Font.body(13), color: PawKit.mist, lines: 2)
    private let minuteLabel = UILabel.pawLabel(font: PawKit.Font.body(12), color: PawKit.silverGray)
    private let xpLabel     = UILabel.pawLabel(font: PawKit.Font.mono(12), color: PawKit.amber)
    private let checkIcon: UIImageView = {
        let cfg = UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
        let iv = UIImageView(image: UIImage(systemName: "checkmark.circle.fill", withConfiguration: cfg))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = PawKit.leaf
        iv.isHidden = true
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        card.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(card)

        // Accent left bar
        accentBar.translatesAutoresizingMaskIntoConstraints = false
        accentBar.backgroundColor = PawKit.leaf
        accentBar.layer.cornerRadius = 2
        accentBar.isHidden = true
        card.addSubview(accentBar)

        // "NEXT UP" badge
        nextBadge.translatesAutoresizingMaskIntoConstraints = false
        nextBadge.text = "NEXT UP"
        nextBadge.font = PawKit.Font.rounded(10, weight: .bold)
        nextBadge.textColor = PawKit.forestDeep
        nextBadge.backgroundColor = PawKit.leaf
        nextBadge.layer.cornerRadius = 8
        nextBadge.clipsToBounds = true
        nextBadge.textAlignment = .center
        nextBadge.isHidden = true
        card.addSubview(nextBadge)

        [numberLabel, titleLabel, subLabel, minuteLabel, xpLabel, checkIcon].forEach { card.addSubview($0) }

        NSLayoutConstraint.activate(card.edges(to: contentView) + [
            accentBar.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.m),
            accentBar.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.l),
            accentBar.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.l),
            accentBar.widthAnchor.constraint(equalToConstant: 3),

            numberLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.l),
            numberLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.l),

            nextBadge.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            nextBadge.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: PawKit.Spacing.s),
            nextBadge.widthAnchor.constraint(greaterThanOrEqualToConstant: 58),
            nextBadge.heightAnchor.constraint(equalToConstant: 18),

            checkIcon.centerYAnchor.constraint(equalTo: numberLabel.centerYAnchor),
            checkIcon.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.l),

            titleLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.l),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.l),

            subLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.l),
            subLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.l),

            minuteLabel.topAnchor.constraint(equalTo: subLabel.bottomAnchor, constant: PawKit.Spacing.s),
            minuteLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.l),
            minuteLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.l),

            xpLabel.centerYAnchor.constraint(equalTo: minuteLabel.centerYAnchor),
            xpLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.l),
        ])
    }
    required init?(coder: NSCoder) { fatalError() }

    func configure(lesson: Lesson, isCompleted: Bool, isNext: Bool = false) {
        numberLabel.text = lesson.id
        titleLabel.text  = lesson.title
        subLabel.text    = lesson.subtitle
        minuteLabel.text = "⏱ \(lesson.estimatedMinutes) min"
        xpLabel.text     = "+\(lesson.xpReward) XP"

        checkIcon.isHidden = !isCompleted
        nextBadge.isHidden = !isNext
        accentBar.isHidden = !isNext

        card.alpha = isCompleted ? 0.55 : 1.0
        card.backgroundColor = isNext ? PawKit.forestMid.withAlphaComponent(0.5) : PawKit.forestDark
    }
}

// MARK: — Lesson Detail

final class LessonDetailViewController: UIViewController {

    private let lesson: Lesson
    var onComplete: ((String) -> Void)?

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
        s.spacing = PawKit.Spacing.m
        return s
    }()

    private let completeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Mark Complete"
        config.baseBackgroundColor = PawKit.leaf
        config.baseForegroundColor = PawKit.forestDeep
        config.cornerStyle = .fixed
        config.background.cornerRadius = PawKit.Radius.button
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { a in
            var b = a; b.font = PawKit.Font.title(17); return b
        }
        let b = UIButton(configuration: config)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    init(lesson: Lesson) {
        self.lesson = lesson
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = lesson.id
        setupLayout()
        populate()
        completeButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        view.addSubview(completeButton)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            completeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -PawKit.Spacing.m),
            completeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),
            completeButton.heightAnchor.constraint(equalToConstant: 52),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: -PawKit.Spacing.m),

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: PawKit.Spacing.m),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: PawKit.Spacing.m),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -PawKit.Spacing.m),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -PawKit.Spacing.m),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -PawKit.Spacing.m * 2),
        ])
    }

    private func populate() {
        let titleLbl = UILabel.pawLabel(text: lesson.title,    font: PawKit.Font.hero(24), color: .white, lines: 0)
        let subLbl   = UILabel.pawLabel(text: lesson.subtitle, font: PawKit.Font.body(14), color: PawKit.mist, lines: 0)
        let metaLbl  = UILabel.pawLabel(
            text: "⏱ \(lesson.estimatedMinutes) min  ·  +\(lesson.xpReward) XP",
            font: PawKit.Font.mono(12), color: PawKit.amber
        )
        [titleLbl, subLbl, metaLbl].forEach { contentStack.addArrangedSubview($0) }

        for section in lesson.content {
            let card = PawCardView()
            card.translatesAutoresizingMaskIntoConstraints = false

            // Color-coded left bar per section type
            let bar = UIView()
            bar.translatesAutoresizingMaskIntoConstraints = false
            bar.backgroundColor = accentColor(for: section.type)
            bar.layer.cornerRadius = 2
            card.addSubview(bar)

            let accent = accentColor(for: section.type)
            let typeLabel = UILabel.pawLabel(text: sectionTypeTitle(section.type),
                                             font: PawKit.Font.rounded(11, weight: .bold), color: accent)
            let bodyLabel = UILabel.pawLabel(text: section.text, font: PawKit.Font.body(14),
                                             color: PawKit.mist, lines: 0)
            card.addSubview(typeLabel)
            card.addSubview(bodyLabel)

            NSLayoutConstraint.activate([
                bar.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.m),
                bar.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.m),
                bar.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.m),
                bar.widthAnchor.constraint(equalToConstant: 3),

                typeLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.m),
                typeLabel.leadingAnchor.constraint(equalTo: bar.trailingAnchor, constant: PawKit.Spacing.m),

                bodyLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: PawKit.Spacing.s),
                bodyLabel.leadingAnchor.constraint(equalTo: bar.trailingAnchor, constant: PawKit.Spacing.m),
                bodyLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.m),
                bodyLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.m),
            ])

            contentStack.addArrangedSubview(card)
        }
    }

    private func sectionTypeTitle(_ type: LessonSection.SectionType) -> String {
        switch type {
        case .hook:           return "🎣 HOOK"
        case .concept:        return "📐 CONCEPT"
        case .example:        return "🔬 EXAMPLE"
        case .keyInsight:     return "💡 KEY INSIGHT"
        case .summary:        return "✅ SUMMARY"
        case .socratiсPrompt: return "🤔 THINK"
        }
    }

    private func accentColor(for type: LessonSection.SectionType) -> UIColor {
        switch type {
        case .hook:           return PawKit.amber
        case .concept:        return PawKit.leaf
        case .example:        return PawKit.mist
        case .keyInsight:     return PawKit.gold
        case .summary:        return PawKit.coral
        case .socratiсPrompt: return PawKit.silverGray
        }
    }

    @objc private func completeTapped() {
        PawKit.haptics.success()
        onComplete?(lesson.id)
        navigationController?.popViewController(animated: true)
    }
}
