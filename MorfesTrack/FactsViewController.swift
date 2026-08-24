import UIKit

final class FactsViewController: UIViewController {

    private let facts = CompetitiveFactVault.facts
    private var currentIndex: Int = 0

    // MARK: — UI

    private let counterLabel = UILabel.pawLabel(
        font: PawKit.Font.mono(13), color: PawKit.silverGray, alignment: .center
    )

    private let cardView = PawCardView()

    private let factLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font          = PawKit.Font.body(16)
        l.textColor     = PawKit.mist
        l.numberOfLines = 0
        l.textAlignment = .left
        return l
    }()

    private let bulbIcon: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "💡"
        l.font = .systemFont(ofSize: 32)
        return l
    }()

    private let prevButton: UIButton = makeNavButton(icon: "chevron.left")
    private let nextButton: UIButton = makeNavButton(icon: "chevron.right")

    private let randomButton: UIButton = {
        var config = UIButton.Configuration.tinted()
        config.title = "Random"
        config.image = UIImage(systemName: "shuffle")
        config.imagePadding = PawKit.Spacing.s
        config.baseBackgroundColor = PawKit.forestDark
        config.baseForegroundColor = PawKit.amber
        config.cornerStyle = .fixed
        config.background.cornerRadius = PawKit.Radius.button
        return UIButton(configuration: config)
    }()

    // MARK: — Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "Facts"
        currentIndex = Int.random(in: 0..<facts.count)
        setupLayout()
        render()

        prevButton.addTarget(self,   action: #selector(prevTapped),   for: .touchUpInside)
        nextButton.addTarget(self,   action: #selector(nextTapped),   for: .touchUpInside)
        randomButton.addTarget(self, action: #selector(randomTapped), for: .touchUpInside)

        let swipeLeft  = UISwipeGestureRecognizer(target: self, action: #selector(nextTapped))
        swipeLeft.direction = .left
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(prevTapped))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeRight)
    }

    // MARK: — Layout

    private func setupLayout() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        randomButton.translatesAutoresizingMaskIntoConstraints = false

        [bulbIcon, factLabel].forEach { cardView.addSubview($0) }

        let navRow = UIStackView(arrangedSubviews: [prevButton, counterLabel, nextButton])
        navRow.translatesAutoresizingMaskIntoConstraints = false
        navRow.spacing = PawKit.Spacing.m
        navRow.alignment = .center

        [cardView, navRow, randomButton].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: PawKit.Spacing.xl),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),

            bulbIcon.topAnchor.constraint(equalTo: cardView.topAnchor, constant: PawKit.Spacing.l),
            bulbIcon.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: PawKit.Spacing.l),

            factLabel.topAnchor.constraint(equalTo: bulbIcon.bottomAnchor, constant: PawKit.Spacing.m),
            factLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: PawKit.Spacing.l),
            factLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -PawKit.Spacing.l),
            factLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -PawKit.Spacing.l),

            navRow.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: PawKit.Spacing.xl),
            navRow.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            randomButton.topAnchor.constraint(equalTo: navRow.bottomAnchor, constant: PawKit.Spacing.l),
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            randomButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }

    // MARK: — Render

    private func render() {
        factLabel.text   = facts[currentIndex]
        counterLabel.text = "\(currentIndex + 1) / \(facts.count)"
        prevButton.isEnabled = currentIndex > 0
        nextButton.isEnabled = currentIndex < facts.count - 1
        UIView.transition(with: cardView, duration: 0.3, options: .transitionCrossDissolve) {}
    }

    // MARK: — Actions

    @objc private func prevTapped() {
        guard currentIndex > 0 else { return }
        PawKit.haptics.tap()
        currentIndex -= 1
        render()
    }

    @objc private func nextTapped() {
        guard currentIndex < facts.count - 1 else { return }
        PawKit.haptics.tap()
        currentIndex += 1
        render()
    }

    @objc private func randomTapped() {
        PawKit.haptics.pin()
        currentIndex = Int.random(in: 0..<facts.count)
        render()
    }

    private static func makeNavButton(icon: String) -> UIButton {
        var config = UIButton.Configuration.tinted()
        config.image = UIImage(systemName: icon, withConfiguration:
            UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold))
        config.baseBackgroundColor = PawKit.forestDark
        config.baseForegroundColor = PawKit.leaf
        config.cornerStyle = .fixed
        config.background.cornerRadius = PawKit.Radius.button
        let b = UIButton(configuration: config)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.widthAnchor.constraint(equalToConstant: 48).isActive = true
        b.heightAnchor.constraint(equalToConstant: 48).isActive = true
        return b
    }
}
