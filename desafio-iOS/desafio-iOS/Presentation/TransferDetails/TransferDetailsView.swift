import Foundation
import UIKit

class TransferDetailsView: UIView {
    let constants = TransferDetailsViewConstants()

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private properties
    /// Label

    // MARK: Value
    private lazy var valueTitleLabel: UILabel = createLabel(for: .regularBody, text: constants.valueTitle)

    // MARK: Date
    private lazy var dateTitleLabel: UILabel = createLabel(for: .regularBody, text: constants.dateTitle)

    // MARK: Sender
    private lazy var senderTitleLabel: UILabel = createLabel(for: .regularBody, text: constants.senderTitle)

    // MARK: Recipient
    private  lazy var recipientTitleLabel: UILabel = createLabel(for: .regularBody, text: constants.senderTitle)

    // MARK: Description
    private lazy var descriptionTitle: UILabel = createLabel(for: .regularBody, text: constants.descriptionTitle)

    private lazy var descriptionLabel: UILabel = createLabel(for: .regularFootnote, text: constants.descriptionText)

    /// StackView
    private lazy var descriptionStackView: UIStackView = createStackView(
        for: .vertical, arrangedSubviews: [descriptionTitle, descriptionLabel],
        spacing: Paddings.quarck)

    // MARK: Public properties
    /// Label

    // MARK: Title
    lazy var titleLabel: UILabel = createLabel(for: .heavyBody)

    // MARK: Value
    lazy var valueLabel: UILabel = createLabel(for: .heavyBody)

    // MARK: Date
    lazy var dateLabel: UILabel = createLabel(for: .heavyBody)

    // MARK: Sender
    lazy var senderNameLabel: UILabel = createLabel(for: .heavyBody)
    lazy var senderRegisterLabel: UILabel = createLabel(for: .regularSupport)
    lazy var senderBankLabel: UILabel = createLabel(for: .regularSupport)
    lazy var senderAccountLabel: UILabel = createLabel(for: .regularSupport)

    // MARK: Recipient
    lazy var recipientNameLabel: UILabel = createLabel(for: .heavyBody)
    lazy var recipientRegisterLabel: UILabel = createLabel(for: .regularSupport)
    lazy var recipientBankLabel: UILabel = createLabel(for: .regularSupport)
    lazy var recipientAccountLabel: UILabel = createLabel(for: .regularSupport)

    /// StackView

    // MARK: MainStackView
    private lazy var mainStackView: UIStackView = createStackView(for: .main,
    arrangedSubviews: [titleStackView, valueStackView, dateStackView, senderStackView,
                       recipientStackView, descriptionStackView, shareButton])

    // MARK: Title
    lazy var titleStackView: UIStackView = createStackView(
        for: .horizontal, arrangedSubviews: [iconImageView, titleLabel],
        spacing: Paddings.nano)

    // MARK: Value
    lazy var valueStackView: UIStackView = createStackView(
        for: .vertical, arrangedSubviews: [valueTitleLabel, valueLabel],
        spacing: Paddings.quarck)

    // MARK: Date
    lazy var dateStackView: UIStackView = createStackView(for: .vertical,
                                                          arrangedSubviews: [dateTitleLabel, dateLabel],
                                                          spacing: Paddings.quarck)

    // MARK: Sender
    lazy var senderAccountInformationStackView: UIStackView = createStackView(
        for: .vertical, arrangedSubviews: [senderRegisterLabel, senderBankLabel, senderAccountLabel],
        spacing: Paddings.none)

    lazy var senderStackView: UIStackView = createStackView(
        for: .vertical, arrangedSubviews: [senderTitleLabel, senderNameLabel,
                           senderAccountInformationStackView],
        spacing: Paddings.quarck)

    // MARK: Recipient
    lazy var recipientAccountInformationStackView: UIStackView = createStackView(
        for: .vertical, arrangedSubviews: [recipientRegisterLabel, recipientBankLabel, recipientAccountLabel])

    lazy var recipientStackView: UIStackView = createStackView(
        for: .vertical, arrangedSubviews: [recipientTitleLabel, recipientNameLabel,
                           recipientAccountInformationStackView])

    /// Image
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrow-up"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    /// Button
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(constants.shareButtonText, for: .normal)
        button.layer.cornerRadius = Paddings.xxxs
        button.setTitleColor(Colors.white, for: .normal)
        button.titleLabel?.font = Fonts.sHeavy.font
        button.backgroundColor = Colors.brandPrimary
        button.semanticContentAttribute = .forceRightToLeft
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: Paddings.none,
                                              left: Paddings.xxs,
                                              bottom: Paddings.none,
                                              right: -Paddings.xxs)

        return button
    }()

}

extension TransferDetailsView: ViewCode {
    func addSubviews() {
        addSubview(mainStackView)
    }

    func setupConstraints() {
        let safeGuide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: Paddings.xs),
            mainStackView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: Paddings.xxs),
            mainStackView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -Paddings.xxs),
            mainStackView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -Paddings.xxs),

            shareButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: Paddings.lg)
        ])
    }

    func setupStyle() {
        backgroundColor = Colors.white
    }
}
