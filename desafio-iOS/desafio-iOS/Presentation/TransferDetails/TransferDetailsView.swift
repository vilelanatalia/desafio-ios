import Foundation
import UIKit

class TransferDetailsView: UIView {
    let constants = TransferDetailsViewConstants()

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: title view stackview

    func regularStackView(arrangedSubviews: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacing
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }

    func horizontalStackView(arrangedSubviews: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacing
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }

    // MARK: Value label

    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "arrow-up"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    lazy var titleLabel: UILabel = createLabel(for: .heavyBody)

    lazy var titleStackView: UIStackView = horizontalStackView(
        arrangedSubviews: [iconImageView, titleLabel],
        spacing: Paddings.nano
    )

    lazy var valueTitleLabel: UILabel = createLabel(for: .regularBody, text: constants.valueTitle)
    lazy var valueLabel: UILabel = createLabel(for: .heavyBody)

    lazy var valueStackView: UIStackView = regularStackView(
        arrangedSubviews: [valueTitleLabel, valueLabel],
        spacing: Paddings.quarck)
    lazy var dateTitleLabel: UILabel = createLabel(for: .regularBody, text: constants.dateTitle)
    lazy var dateLabel: UILabel = createLabel(for: .heavyBody)

    lazy var dateStackView: UIStackView = regularStackView(
        arrangedSubviews: [dateTitleLabel, dateLabel],
        spacing: Paddings.quarck)

    // MARK: Sender

    lazy var senderTitleLabel: UILabel = createLabel(for: .regularBody, text: constants.senderTitle)
    lazy var senderNameLabel: UILabel = createLabel(for: .heavyBody)

    lazy var senderRegisterLabel: UILabel = createLabel(for: .regularSupport)
    lazy var senderBankLabel: UILabel = createLabel(for: .regularSupport)
    lazy var senderAccountLabel: UILabel = createLabel(for: .regularSupport)

    lazy var senderAccountInformationStackView: UIStackView = regularStackView(
        arrangedSubviews: [senderRegisterLabel, senderBankLabel, senderAccountLabel],
        spacing: Paddings.none)

    lazy var senderStackView: UIStackView = regularStackView(
        arrangedSubviews: [senderTitleLabel, senderNameLabel,
                           senderAccountInformationStackView],
        spacing: Paddings.quarck)

    // MARK: Recipient

    lazy var recipientTitleLabel: UILabel = createLabel(for: .regularBody, text: constants.senderTitle)
    lazy var recipientNameLabel: UILabel = createLabel(for: .heavyBody)

    lazy var recipientRegisterLabel: UILabel = createLabel(for: .regularSupport)
    lazy var recipientBankLabel: UILabel = createLabel(for: .regularSupport)
    lazy var recipientAccountLabel: UILabel = createLabel(for: .regularSupport)

    lazy var recipientAccountInformationStackView: UIStackView = regularStackView(
        arrangedSubviews: [recipientRegisterLabel, recipientBankLabel, recipientAccountLabel],
        spacing: Paddings.none)

    lazy var recipientStackView: UIStackView = regularStackView(
        arrangedSubviews: [recipientTitleLabel, recipientNameLabel,
                           recipientAccountInformationStackView],
        spacing: Paddings.quarck)

    private lazy var descriptionTitle: UILabel = createLabel(for: .regularBody, text: constants.descriptionTitle)
    private lazy var descriptionLabel: UILabel = createLabel(for: .regularFootnote, text: constants.descriptionText)
    lazy var descriptionStackView: UIStackView = regularStackView(
        arrangedSubviews: [descriptionTitle, descriptionLabel],
        spacing: Paddings.quarck)

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


    private lazy var mainStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, valueStackView, dateStackView, senderStackView, recipientStackView, descriptionStackView, shareButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.axis = .vertical
        return stackView
    }()
}

extension TransferDetailsView: ViewCode {
    func addSubviews() {
        addSubview(mainStack)
    }

    func setupConstraints() {
        let safeGuide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            // titleStackView
            mainStack.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: Paddings.xs),
            mainStack.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: Paddings.xxs),
            mainStack.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -Paddings.xxs),
            mainStack.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -Paddings.xxs),

            shareButton.widthAnchor.constraint(equalTo: mainStack.widthAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: Paddings.lg)
        ])
    }

    func setupStyle() {
        backgroundColor = Colors.white
    }
}
