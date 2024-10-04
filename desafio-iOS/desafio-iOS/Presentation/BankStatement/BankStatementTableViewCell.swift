import UIKit

class BankStatementTableViewCell: UITableViewCell {

    private lazy var cellStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionStackView, dateEventLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    lazy var transactionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [transactionIconImageView, informationStackView])
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

    private lazy var informationStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [amountLabel, descriptionLabel, nameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    lazy var amountLabel: UILabel = createLabel(for: .heavyBody)
    lazy var descriptionLabel: UILabel = createLabel(for: .regularBody)
    lazy var nameLabel: UILabel = createLabel(for: .regularSupport)
    lazy var dateEventLabel: UILabel = createLabel(for: .regularFootnote)

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
    }

    func addSubviews() {
        addSubview(cellStackView)
    }

    func setupConstraints() {
        let safeGuide = safeAreaLayoutGuide


        NSLayoutConstraint.activate([
            cellStackView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: Paddings.xxs),
            cellStackView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: Paddings.xxs),
            cellStackView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -Paddings.xxs),
            cellStackView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -Paddings.xxs),

            transactionStackView.widthAnchor.constraint(equalTo: cellStackView.widthAnchor, multiplier: 0.8),

            dateEventLabel.centerYAnchor.constraint(equalTo: cellStackView.centerYAnchor)

        ])
    }
}
