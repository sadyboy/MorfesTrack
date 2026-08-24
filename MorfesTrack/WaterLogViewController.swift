import UIKit

// MARK: — Model

struct WaterLogEntry: Codable {
    var date: Date
    var ph: Double?
    var tempC: Double?
    var ammonia: Double?
    var nitrite: Double?
    var nitrate: Double?
    var notes: String
}

// MARK: — Status helpers

private enum ParamStatus { case good, warn, danger }

private func statusColor(_ s: ParamStatus) -> UIColor {
    switch s {
    case .good:   return PawKit.leaf
    case .warn:   return PawKit.amber
    case .danger: return PawKit.coral
    }
}

private func phStatus(_ v: Double) -> ParamStatus {
    v >= 6.5 && v <= 7.5 ? .good : (v >= 6.0 && v <= 8.0 ? .warn : .danger)
}
private func tempStatus(_ v: Double) -> ParamStatus {
    v >= 22 && v <= 26 ? .good : (v >= 18 && v <= 30 ? .warn : .danger)
}
private func ammoniaStatus(_ v: Double) -> ParamStatus {
    v == 0 ? .good : (v <= 0.25 ? .warn : .danger)
}
private func nitriteStatus(_ v: Double) -> ParamStatus {
    v == 0 ? .good : (v <= 0.5 ? .warn : .danger)
}
private func nitrateStatus(_ v: Double) -> ParamStatus {
    v <= 20 ? .good : (v <= 40 ? .warn : .danger)
}

// MARK: — List

final class WaterLogViewController: UIViewController {

    private var entries: [WaterLogEntry] = []

    private let emptyIcon: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "🧪"
        l.font = .systemFont(ofSize: 52)
        l.textAlignment = .center
        return l
    }()

    private let emptyLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "No readings yet.\nTap + to log your tank parameters."
        l.font = PawKit.Font.body(15)
        l.textColor = PawKit.silverGray
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()

    private let emptyStack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .vertical
        s.spacing = PawKit.Spacing.m
        s.alignment = .center
        return s
    }()

    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        tv.separatorStyle = .none
        tv.register(WaterLogCell.self, forCellReuseIdentifier: WaterLogCell.reuseID)
        tv.contentInset = UIEdgeInsets(top: PawKit.Spacing.m, left: 0,
                                       bottom: PawKit.Spacing.xl, right: 0)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "Tank Log"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self, action: #selector(addTapped)
        )
        setupLayout()
        loadEntries()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadEntries()
    }

    private func setupLayout() {
        emptyStack.addArrangedSubview(emptyIcon)
        emptyStack.addArrangedSubview(emptyLabel)

        view.addSubview(tableView)
        view.addSubview(emptyStack)
        tableView.dataSource = self

        NSLayoutConstraint.activate(tableView.edges(to: view) + [
            emptyStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyStack.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            emptyStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.xl),
            emptyStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.xl),
        ])
    }

    private func loadEntries() {
        if let data = UserDefaults.standard.data(forKey: "waterLogEntries"),
           let decoded = try? JSONDecoder().decode([WaterLogEntry].self, from: data) {
            entries = decoded.sorted { $0.date > $1.date }
        } else {
            entries = []
        }
        tableView.reloadData()
        let isEmpty = entries.isEmpty
        emptyStack.isHidden = !isEmpty
        tableView.isHidden  = isEmpty
    }

    @objc private func addTapped() {
        PawKit.haptics.tap()
        let vc = AddWaterLogViewController()
        vc.onSave = { [weak self] entry in self?.appendEntry(entry) }
        navigationController?.pushViewController(vc, animated: true)
    }

    private func appendEntry(_ entry: WaterLogEntry) {
        entries.insert(entry, at: 0)
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: "waterLogEntries")
        }
        tableView.reloadData()
        emptyStack.isHidden = true
        tableView.isHidden  = false
    }
}

extension WaterLogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: WaterLogCell.reuseID, for: indexPath) as! WaterLogCell
        cell.configure(entries[indexPath.row])
        return cell
    }
}

// MARK: — Cell

final class WaterLogCell: UITableViewCell {
    static let reuseID = "WaterLogCell"

    private let card       = PawCardView()
    private let dateLabel  = UILabel()
    private let chipRow    = UIStackView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle  = .none

        card.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(card)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font      = PawKit.Font.mono(12)
        dateLabel.textColor = PawKit.silverGray

        chipRow.translatesAutoresizingMaskIntoConstraints = false
        chipRow.axis      = .horizontal
        chipRow.spacing   = PawKit.Spacing.s
        chipRow.alignment = .center

        [dateLabel, chipRow].forEach { card.addSubview($0) }

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            card.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: PawKit.Spacing.m),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -PawKit.Spacing.m),

            dateLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.m),
            dateLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.m),

            chipRow.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: PawKit.Spacing.s),
            chipRow.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.m),
            chipRow.trailingAnchor.constraint(lessThanOrEqualTo: card.trailingAnchor, constant: -PawKit.Spacing.m),
            chipRow.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.m),
        ])
    }
    required init?(coder: NSCoder) { fatalError() }

    func configure(_ entry: WaterLogEntry) {
        let fmt = DateFormatter()
        fmt.dateStyle = .medium
        fmt.timeStyle = .short
        dateLabel.text = fmt.string(from: entry.date)

        chipRow.arrangedSubviews.forEach { $0.removeFromSuperview() }

        if let v = entry.ph      { chipRow.addArrangedSubview(chip("pH \(fmt1(v))",     statusColor(phStatus(v)))) }
        if let v = entry.tempC   { chipRow.addArrangedSubview(chip("\(fmt0(v))°C",       statusColor(tempStatus(v)))) }
        if let v = entry.ammonia { chipRow.addArrangedSubview(chip("NH₃ \(fmt2(v))",    statusColor(ammoniaStatus(v)))) }
        if let v = entry.nitrite { chipRow.addArrangedSubview(chip("NO₂ \(fmt2(v))",    statusColor(nitriteStatus(v)))) }
        if let v = entry.nitrate { chipRow.addArrangedSubview(chip("NO₃ \(fmt0(v))",    statusColor(nitrateStatus(v)))) }
        if chipRow.arrangedSubviews.isEmpty {
            chipRow.addArrangedSubview(chip("—", PawKit.silverGray))
        }
    }

    private func chip(_ text: String, _ color: UIColor) -> UIView {
        let bg = UIView()
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.backgroundColor = color.withAlphaComponent(0.15)
        bg.layer.cornerRadius = 6

        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text          = text
        l.font          = PawKit.Font.mono(11)
        l.textColor     = color
        l.textAlignment = .center
        bg.addSubview(l)

        NSLayoutConstraint.activate([
            l.topAnchor.constraint(equalTo: bg.topAnchor, constant: 5),
            l.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -5),
            l.leadingAnchor.constraint(equalTo: bg.leadingAnchor, constant: 8),
            l.trailingAnchor.constraint(equalTo: bg.trailingAnchor, constant: -8),
        ])
        return bg
    }
}

private func fmt0(_ v: Double) -> String { String(format: "%.0f", v) }
private func fmt1(_ v: Double) -> String { String(format: "%.1f", v) }
private func fmt2(_ v: Double) -> String { String(format: "%.2f", v) }

// MARK: — Add Log

final class AddWaterLogViewController: UIViewController {

    var onSave: ((WaterLogEntry) -> Void)?

    private let scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.showsVerticalScrollIndicator = false
        s.keyboardDismissMode = .interactive
        return s
    }()

    private let contentStack: UIStackView = {
        let s = UIStackView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis    = .vertical
        s.spacing = PawKit.Spacing.m
        return s
    }()

    private let phField    = logField("pH",             "e.g. 7.0   optimal: 6.5–7.5")
    private let tempField  = logField("Temperature °C", "e.g. 24    optimal: 22–26")
    private let nh3Field   = logField("Ammonia (ppm)",  "e.g. 0.00  ideal: 0")
    private let no2Field   = logField("Nitrite (ppm)",  "e.g. 0.00  ideal: 0")
    private let no3Field   = logField("Nitrate (ppm)",  "e.g. 10    optimal: <20")
    private let notesField = logField("Notes",          "Water change, ferts added…", numeric: false)

    private let saveButton: UIButton = {
        var cfg = UIButton.Configuration.filled()
        cfg.title                  = "Save Reading"
        cfg.baseBackgroundColor    = PawKit.leaf
        cfg.baseForegroundColor    = PawKit.forestDeep
        cfg.cornerStyle            = .fixed
        cfg.background.cornerRadius = PawKit.Radius.button
        cfg.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { a in
            var b = a; b.font = PawKit.Font.title(17); return b
        }
        let btn = UIButton(configuration: cfg)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "New Reading"

        for row in [phField, tempField, nh3Field, no2Field, no3Field, notesField] {
            contentStack.addArrangedSubview(row)
        }

        view.addSubview(scrollView)
        view.addSubview(saveButton)
        scrollView.addSubview(contentStack)

        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -PawKit.Spacing.m),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),
            saveButton.heightAnchor.constraint(equalToConstant: 52),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -PawKit.Spacing.m),

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: PawKit.Spacing.m),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: PawKit.Spacing.m),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -PawKit.Spacing.m),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -PawKit.Spacing.m),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                                constant: -PawKit.Spacing.m * 2),
        ])

        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }

    @objc private func saveTapped() {
        PawKit.haptics.success()
        let entry = WaterLogEntry(
            date:     Date(),
            ph:       valueFrom(phField),
            tempC:    valueFrom(tempField),
            ammonia:  valueFrom(nh3Field),
            nitrite:  valueFrom(no2Field),
            nitrate:  valueFrom(no3Field),
            notes:    stringFrom(notesField)
        )
        onSave?(entry)
        let diagVC = TankDiagnosticViewController(entry: entry)
        navigationController?.pushViewController(diagVC, animated: true)
    }

    private func valueFrom(_ container: UIView) -> Double? {
        guard let tf = container.subviews.compactMap({ $0 as? UITextField }).last,
              let t = tf.text, !t.isEmpty else { return nil }
        return Double(t.replacingOccurrences(of: ",", with: "."))
    }

    private func stringFrom(_ container: UIView) -> String {
        container.subviews.compactMap({ $0 as? UITextField }).last?.text ?? ""
    }
}

// MARK: — Field factory

private func logField(_ labelText: String, _ placeholder: String, numeric: Bool = true) -> UIView {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false

    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text      = labelText
    label.font      = PawKit.Font.rounded(13, weight: .semibold)
    label.textColor = PawKit.mist

    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.backgroundColor    = PawKit.forestDark
    tf.textColor          = .white
    tf.font               = PawKit.Font.body(15)
    tf.layer.cornerRadius = PawKit.Radius.button
    tf.leftView           = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
    tf.leftViewMode       = .always
    tf.attributedPlaceholder = NSAttributedString(
        string: placeholder,
        attributes: [.foregroundColor: PawKit.silverGray]
    )
    tf.keyboardType      = numeric ? .decimalPad : .default
    tf.autocorrectionType = .no

    [label, tf].forEach { container.addSubview($0) }
    NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: container.topAnchor),
        label.leadingAnchor.constraint(equalTo: container.leadingAnchor),

        tf.topAnchor.constraint(equalTo: label.bottomAnchor, constant: PawKit.Spacing.s),
        tf.leadingAnchor.constraint(equalTo: container.leadingAnchor),
        tf.trailingAnchor.constraint(equalTo: container.trailingAnchor),
        tf.heightAnchor.constraint(equalToConstant: 48),
        tf.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])
    return container
}

// MARK: — Tank Diagnostic

final class TankDiagnosticViewController: UIViewController {

    private let entry: WaterLogEntry

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
    private let doneButton: UIButton = {
        var cfg = UIButton.Configuration.filled()
        cfg.title = "Got it  ✓"
        cfg.baseBackgroundColor = PawKit.leaf
        cfg.baseForegroundColor = PawKit.forestDeep
        cfg.cornerStyle = .fixed
        cfg.background.cornerRadius = PawKit.Radius.button
        cfg.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { a in
            var b = a; b.font = PawKit.Font.title(17); return b
        }
        let btn = UIButton(configuration: cfg)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    init(entry: WaterLogEntry) {
        self.entry = entry
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = PawKit.forestDeep
        title = "Water Analysis"
        navigationItem.hidesBackButton = true
        setupLayout()
        buildDiagnostic()
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        view.addSubview(doneButton)
        scrollView.addSubview(contentStack)
        NSLayoutConstraint.activate([
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -PawKit.Spacing.m),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: PawKit.Spacing.m),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -PawKit.Spacing.m),
            doneButton.heightAnchor.constraint(equalToConstant: 52),

            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: doneButton.topAnchor, constant: -PawKit.Spacing.m),

            contentStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: PawKit.Spacing.m),
            contentStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: PawKit.Spacing.m),
            contentStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -PawKit.Spacing.m),
            contentStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -PawKit.Spacing.m),
            contentStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -PawKit.Spacing.m * 2),
        ])
    }

    private func buildDiagnostic() {
        let findings = diagnose(entry)
        let hasIssues = findings.contains { $0.level != .ok }

        let heroIcon = UILabel()
        heroIcon.translatesAutoresizingMaskIntoConstraints = false
        heroIcon.text = hasIssues ? "⚠️" : "✅"
        heroIcon.font = .systemFont(ofSize: 48)
        heroIcon.textAlignment = .center
        contentStack.addArrangedSubview(heroIcon)

        let summaryLbl = UILabel.pawLabel(
            text: hasIssues ? "Issues detected — action recommended" : "All parameters look great!",
            font: PawKit.Font.title(18), color: hasIssues ? PawKit.amber : PawKit.leaf,
            alignment: .center, lines: 0
        )
        contentStack.addArrangedSubview(summaryLbl)

        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = PawKit.forestMid
        divider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        contentStack.addArrangedSubview(divider)

        for item in findings {
            contentStack.addArrangedSubview(findingCard(item))
        }

        if !hasIssues {
            let tip = UILabel.pawLabel(
                text: "💬 Pro tip: Log your parameters at the same time each day — consistency reveals trends that one-off tests miss.",
                font: PawKit.Font.body(13), color: PawKit.mist, alignment: .left, lines: 0
            )
            contentStack.addArrangedSubview(tip)
        }
    }

    private func findingCard(_ item: DiagnosticItem) -> UIView {
        let card = PawCardView()
        card.translatesAutoresizingMaskIntoConstraints = false

        let bar = UIView()
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.backgroundColor = item.color
        bar.layer.cornerRadius = 2
        card.addSubview(bar)

        let paramLbl = UILabel.pawLabel(text: item.param, font: PawKit.Font.rounded(12, weight: .bold), color: item.color)
        let valueLbl = UILabel.pawLabel(text: item.value, font: PawKit.Font.mono(13), color: .white)
        let recLbl   = UILabel.pawLabel(text: item.recommendation, font: PawKit.Font.body(13), color: PawKit.mist,
                                        alignment: .left, lines: 0)
        [paramLbl, valueLbl, recLbl].forEach { card.addSubview($0) }

        NSLayoutConstraint.activate([
            bar.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: PawKit.Spacing.m),
            bar.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.m),
            bar.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.m),
            bar.widthAnchor.constraint(equalToConstant: 3),

            paramLbl.topAnchor.constraint(equalTo: card.topAnchor, constant: PawKit.Spacing.m),
            paramLbl.leadingAnchor.constraint(equalTo: bar.trailingAnchor, constant: PawKit.Spacing.m),

            valueLbl.centerYAnchor.constraint(equalTo: paramLbl.centerYAnchor),
            valueLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.m),

            recLbl.topAnchor.constraint(equalTo: paramLbl.bottomAnchor, constant: PawKit.Spacing.s),
            recLbl.leadingAnchor.constraint(equalTo: bar.trailingAnchor, constant: PawKit.Spacing.m),
            recLbl.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -PawKit.Spacing.m),
            recLbl.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -PawKit.Spacing.m),
        ])
        return card
    }

    @objc private func doneTapped() {
        PawKit.haptics.tap()
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: — Diagnostic Engine

private enum DiagnosticLevel { case ok, warn, danger }

private struct DiagnosticItem {
    let param: String
    let value: String
    let level: DiagnosticLevel
    let recommendation: String
    var color: UIColor {
        switch level {
        case .ok:     return PawKit.leaf
        case .warn:   return PawKit.amber
        case .danger: return PawKit.coral
        }
    }
}

private func diagnose(_ e: WaterLogEntry) -> [DiagnosticItem] {
    var items: [DiagnosticItem] = []

    if let v = e.ph {
        let (level, rec): (DiagnosticLevel, String) = v < 6.0
            ? (.danger, "pH critically low. Reduce CO₂ injection and add crushed coral to raise pH gradually.")
            : v > 8.0
            ? (.danger, "pH too high. Check for excess aeration. Peat filtration or driftwood can help.")
            : v < 6.5 || v > 7.5
            ? (.warn,   "pH slightly outside optimal. Monitor for 24 h and consider a partial water change.")
            : (.ok,     "pH is within the ideal competition range of 6.5–7.5.")
        items.append(DiagnosticItem(param: "pH", value: String(format: "%.1f", v), level: level, recommendation: rec))
    }

    if let v = e.ammonia {
        let (level, rec): (DiagnosticLevel, String) = v > 0.5
            ? (.danger, "Toxic ammonia level. Perform a 50% water change immediately. Do not feed until zero.")
            : v > 0
            ? (.warn,   "Trace ammonia present. Check filter media and reduce feeding. Consider adding a bacterial supplement.")
            : (.ok,     "Zero ammonia — nitrogen cycle is fully established.")
        items.append(DiagnosticItem(param: "Ammonia (NH₃)", value: String(format: "%.2f ppm", v), level: level, recommendation: rec))
    }

    if let v = e.nitrite {
        let (level, rec): (DiagnosticLevel, String) = v > 0.5
            ? (.danger, "High nitrite — toxic to fish and shrimp. 30–50% daily water changes until zero.")
            : v > 0
            ? (.warn,   "Low nitrite detected. Cycle may be incomplete. Monitor daily.")
            : (.ok,     "Zero nitrite — excellent filtration performance.")
        items.append(DiagnosticItem(param: "Nitrite (NO₂)", value: String(format: "%.2f ppm", v), level: level, recommendation: rec))
    }

    if let v = e.nitrate {
        let (level, rec): (DiagnosticLevel, String) = v > 40
            ? (.danger, "High nitrate — schedule a 30–40% water change within 24 hours. Reduce feeding frequency.")
            : v > 20
            ? (.warn,   "Nitrate slightly elevated. Plan a water change this week. Fast-growing plants can help absorb it.")
            : (.ok,     "Nitrate under 20 ppm — ideal for competition-level plant growth.")
        items.append(DiagnosticItem(param: "Nitrate (NO₃)", value: String(format: "%.0f ppm", v), level: level, recommendation: rec))
    }

    if let v = e.tempC {
        let (level, rec): (DiagnosticLevel, String) = v > 30 || v < 18
            ? (.danger, "Temperature outside safe range. Adjust heater and increase surface agitation to stabilise.")
            : v > 26 || v < 22
            ? (.warn,   "Temperature slightly off optimal (22–26°C). Fine-tune your heater setting.")
            : (.ok,     "Temperature is within the optimal 22–26°C range.")
        items.append(DiagnosticItem(param: "Temperature", value: String(format: "%.1f°C", v), level: level, recommendation: rec))
    }

    return items
}
