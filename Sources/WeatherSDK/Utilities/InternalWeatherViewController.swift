import UIKit

final class InternalWeatherViewController: UIViewController, WeatherViewController {
    // MARK: - UI Elements
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Style.Size.l
        return stackView
    }()

    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = Style.Size.xs
        return stackView
    }()

    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Style.Fonts.textRegular
        label.textColor = Style.Colors.textPrimary
        return label
    }()

    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Style.Fonts.h1
        label.textColor = Style.Colors.textPrimary
        return label
    }()

    private let skyStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Style.Fonts.textRegular
        label.textColor = Style.Colors.textPrimary
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Style.Fonts.label
        label.textColor = Style.Colors.textSecondary
        return label
    }()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Properties
    private let viewModel: WeatherViewModel
    var delegate: WeatherSDKDelegate?

    // MARK: - Lifecycle
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupBackButton()
        setupSubviews()
        setupConstraints()
        setupContent()
    }

    // MARK: - Setup
    private func setupBackButton() {
        self.navigationItem.hidesBackButton = true

        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "arrow", in: Bundle.module, compatibleWith: nil)
        config.title = "Back"
        config.baseForegroundColor = Style.Colors.accent
        config.imagePadding = Style.Size.s
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -Style.Size.s, bottom: 0, trailing: 0)

        let backButton = UIButton(configuration: config, primaryAction: UIAction { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.onFinished(viewController: self)
        })

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    private func setupSubviews() {
        title = "24H Forecast"
        view.backgroundColor = Style.Colors.background

        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.separatorColor = Style.Colors.textBorder.withAlphaComponent(1.0)
        tableView.rowHeight = Style.Size.xxxl

        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(topStackView)
        mainStackView.addArrangedSubview(tableView)

        topStackView.addArrangedSubview(cityLabel)
        topStackView.addArrangedSubview(temperatureLabel)
        topStackView.addArrangedSubview(skyStatusLabel)
        topStackView.addArrangedSubview(timeLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Style.Size.m),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupContent() {
        cityLabel.text = "The weather in \(viewModel.currentCity) is:"
        temperatureLabel.text = viewModel.currentTemp
        skyStatusLabel.text = viewModel.currentWeather
        timeLabel.text = "AT \(viewModel.currentTime) LOCAL TIME"
    }
}

// MARK: - UITableViewDataSource
extension InternalWeatherViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.configurations.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell else {
            fatalError("Unable to dequeue WeatherCell")
        }

        let configuration = viewModel.configurations[indexPath.row]
        cell.setup(with: configuration)

        return cell
    }
}
