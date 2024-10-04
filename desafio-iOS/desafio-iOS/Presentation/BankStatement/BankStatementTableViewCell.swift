import UIKit

class BankStatementTableViewCell: UITableViewCell {

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private properties
    /// Label
    lazy var amountLabel: UILabel = createLabel(for: .heavyBody)
    lazy var descriptionLabel: UILabel = createLabel(for: .regularBody)
    lazy var nameLabel: UILabel = createLabel(for: .regularSupport)
    lazy var dateEventLabel: UILabel = createLabel(for: .regularFootnote)

    /// StackView
    private lazy var cellStackView: UIStackView = createStackView(for: .horizontalMain,
                                                                  arrangedSubviews: [transactionStackView, dateEventLabel])
    private lazy var transactionStackView: UIStackView = createStackView(for: .horizontal,
                                                                         arrangedSubviews: [transactionIconImageView, informationStackView],
                                                                         spacing: Paddings.xxxs)
    private lazy var informationStackView: UIStackView = createStackView(for: .vertical,
                                                                         arrangedSubviews: [amountLabel, descriptionLabel, nameLabel])
    // MARK: Public properties

    /// ImageView
    lazy var transactionIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
}

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
