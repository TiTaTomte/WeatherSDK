import UIKit

class WeatherCell: UITableViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Style.Fonts.textRegular
        label.textColor = Style.Colors.textPrimary
        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.Colors.textBorder
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        selectionStyle = .none

        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Style.Size.m),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Style.Size.m),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setup(with configuration: CellConfiguration) {
        label.attributedText = configuration.text
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.attributedText = nil
    }
}
