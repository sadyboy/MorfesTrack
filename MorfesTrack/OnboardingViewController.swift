import UIKit

final class OnboardingViewController: UIViewController {

    var onComplete: ((String) -> Void)?

    // MARK: — UI
    private let backgroundView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = PawKit.forestDeep
        return v
    }()

    private let iconImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 64, weight: .thin)
        let iv = UIImageView(image: UIImage(systemName: "water.waves", withConfiguration: config))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.tintColor = PawKit.leaf
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Blingox Luck"
        l.font = PawKit.Font.hero(34)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()

    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Your competitive aquascaping journal"
        l.font = PawKit.Font.body(16)
        l.textColor = PawKit.mist.withAlphaComponent(0.7)
        l.textAlignment = .center
        return l
    }()

    private let promptLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "What should we call you?"
        l.font = PawKit.Font.title(18)
        l.textColor = PawKit.mist
        l.textAlignment = .center
        return l
    }()

    private let nameField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Your name"
        tf.backgroundColor = PawKit.forestDark
        tf.textColor = .white
        tf.font = PawKit.Font.body(16)
        tf.layer.cornerRadius = PawKit.Radius.button
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        tf.leftViewMode = .always
        tf.attributedPlaceholder = NSAttributedString(
            string: "Your name",
            attributes: [.foregroundColor: PawKit.silverGray]
        )
        tf.autocorrectionType = .no
        tf.returnKeyType = .done
        return tf
    }()

    private let beginButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Begin"
        config.baseBackgroundColor = PawKit.leaf
        config.baseForegroundColor = PawKit.forestDeep
        config.cornerStyle = .fixed
        config.background.cornerRadius = PawKit.Radius.button
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attrs in
            var a = attrs
            a.font = PawKit.Font.title(17)
            return a
        }
        let b = UIButton(configuration: config)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.isEnabled = false
        b.alpha = 0.4
        return b
    }()

    // MARK: — Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        nameField.delegate = self
        nameField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        beginButton.addTarget(self, action: #selector(beginTapped), for: .touchUpInside)

        // Animate icon on appear
        iconImageView.alpha = 0
        iconImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.5) {
            self.iconImageView.alpha = 1
            self.iconImageView.transform = .identity
        }
    }

    // MARK: — Layout

    private func setupLayout() {
        view.backgroundColor = PawKit.forestDeep
        [backgroundView, iconImageView, titleLabel, subtitleLabel,
         promptLabel, nameField, beginButton].forEach { view.addSubview($0) }

        NSLayoutConstraint.activate(backgroundView.edges(to: view) + [
            iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            iconImageView.heightAnchor.constraint(equalToConstant: 80),

            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: PawKit.Spacing.l),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: PawKit.Spacing.s),
            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            promptLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 60),
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nameField.topAnchor.constraint(equalTo: promptLabel.bottomAnchor, constant: PawKit.Spacing.m),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.xl),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.xl),
            nameField.heightAnchor.constraint(equalToConstant: 52),

            beginButton.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: PawKit.Spacing.l),
            beginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.xl),
            beginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.xl),
            beginButton.heightAnchor.constraint(equalToConstant: 52),
        ])
    }

    // MARK: — Actions

    @objc private func nameChanged() {
        let hasName = !(nameField.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)
        beginButton.isEnabled = hasName
        UIView.animate(withDuration: 0.2) { self.beginButton.alpha = hasName ? 1.0 : 0.4 }
    }

    @objc private func beginTapped() {
        guard let name = nameField.text?.trimmingCharacters(in: .whitespaces), !name.isEmpty else { return }
        PawKit.haptics.success()
        onComplete?(name)
    }
}

// MARK: — UITextFieldDelegate
extension OnboardingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        beginTapped()
        return true
    }
}
