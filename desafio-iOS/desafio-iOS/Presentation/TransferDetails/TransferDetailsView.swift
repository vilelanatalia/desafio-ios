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

    // MARK: Components

    func regularLabel(text: String? = nil, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.xsRegular.font
        label.textColor = textColor
        label.text = text
        return label
    }

    func boldLabel(text: String? = nil, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.sHeavy.font
        label.textColor = textColor
        label.text = text

        return label
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
        stackView.distribution = .fill // Dis
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

    lazy var titleStackView: UIStackView = horizontalStackView(
        arrangedSubviews: [iconImageView,
                           boldLabel(textColor: Colors.grayscale5!)], spacing: Paddings.nano
    )

    lazy var valueStackView: UIStackView = regularStackView(
        arrangedSubviews: [regularLabel(text: constants.valueTitle, textColor: Colors.grayscale5!),
                           boldLabel(textColor: Colors.grayscale5!)],
        spacing: Paddings.quarck
    )

    lazy var dateStackView: UIStackView = regularStackView(
        arrangedSubviews: [regularLabel(text: constants.dateTitle, textColor: Colors.grayscale5!),
                           boldLabel(textColor: Colors.grayscale5!)],
        spacing: Paddings.quarck
    )

    lazy var senderStackView: UIStackView = regularStackView(
        arrangedSubviews: [regularLabel(text: constants.senderTitle, textColor: Colors.grayscale5!),
                           boldLabel(textColor: Colors.grayscale5!),
                           senderAccountInformationStackView],
        spacing: Paddings.quarck
    )
    lazy var recipientStackView: UIStackView = regularStackView(
        arrangedSubviews: [regularLabel(text: constants.recipientTitle, textColor: Colors.grayscale5!),
                           boldLabel(textColor: Colors.grayscale5!),
                           recipientAccountInformationStackView],
        spacing: Paddings.quarck
    )

    lazy var recipientAccountInformationStackView: UIStackView = regularStackView(
        arrangedSubviews: [regularLabel(textColor: Colors.grayscale2!),
                           regularLabel(textColor: Colors.grayscale2!),
                           regularLabel(textColor: Colors.grayscale2!)],
        spacing: Paddings.none
    )

    lazy var senderAccountInformationStackView: UIStackView = regularStackView(
        arrangedSubviews: [regularLabel(textColor: Colors.grayscale2!),
                           regularLabel(textColor: Colors.grayscale2!),
                           regularLabel(textColor: Colors.grayscale2!)],
        spacing: Paddings.none
    )

    lazy var descriptionStackView: UIStackView = regularStackView(
        arrangedSubviews: [regularLabel(text: constants.descriptionTitle, textColor: Colors.grayscale5!),
                           descriptionLabel],
        spacing: Paddings.quarck
    )

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

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = constants.descriptionText
        label.font = Fonts.xsRegular.font
        label.textColor = Colors.grayscale2
        label.numberOfLines = 0
        return label
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
            shareButton.heightAnchor.constraint(equalToConstant: Paddings.lg),
        ])
    }

    func setupStyle() {
        backgroundColor = Colors.white
    }
}
