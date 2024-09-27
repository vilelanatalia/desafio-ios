import UIKit

class BankStatementTableViewCell: UITableViewCell {
    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionIconImageView, textStackView, dateEventLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = Paddings.xxxs

        return stackView
    }()

    lazy var transactionIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [amountLabel, descriptionLabel, nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()

    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var dateEventLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Methods

extension BankStatementTableViewCell: ViewCode {
    func setupStyle() {
        // MARK: amountLabel style

        amountLabel.font = Fonts.sHeavy.font
        amountLabel.textColor = Colors.labelPrimary

        // MARK: descriptionLabel style

        descriptionLabel.font = Fonts.xsRegular.font
        descriptionLabel.textColor = Colors.labelPrimary

        // MARK: nameLabel style

        nameLabel.font = Fonts.xsRegular.font
        nameLabel.textColor = Colors.grayscale2

        // MARK: dateEventLabel style

        dateEventLabel.font = Fonts.xxsRegular.font
        dateEventLabel.textColor = Colors.grayscale2
    }

    func addSubviews() {
        addSubview(cellStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: topAnchor, constant: Paddings.xxs),
            cellStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxs),
            cellStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxs),
            cellStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Paddings.xxs),

            transactionIconImageView.leadingAnchor.constraint(equalTo: cellStackView.leadingAnchor),

            textStackView.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor),

            dateEventLabel.trailingAnchor.constraint(equalTo: cellStackView.trailingAnchor),
            dateEventLabel.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor),

        ])
    }
}
