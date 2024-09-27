import UIKit

class IntroView: UIView {
    let constants = IntroViewConstants()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = constants.titleText

        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = constants.susbtitleText

        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = constants.descriptionText
        return label
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(constants.signUpTextButton, for: .normal)

        return button
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(constants.loginTextButton, for: .normal)
        return button
    }()

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [signUpButton, loginButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension IntroView: ViewCode {
    func addSubviews() {
        addSubview(imageView)
        addSubview(titleStackView)
        addSubview(descriptionLabel)
        addSubview(buttonStackView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 360),
            imageView.heightAnchor.constraint(equalToConstant: 360),

            titleStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Paddings.xxxs),
            titleStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxxs),
            titleStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxxs),

            descriptionLabel.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: Paddings.xs),

            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxxs),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxxs),

            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxxs),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxxs),
            buttonStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Paddings.xxxs),

            signUpButton.heightAnchor.constraint(equalToConstant: 64),
            loginButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }

    func setupStyle() {
        backgroundColor = Colors.brandPrimary

        // MARK: titleLabel style

        titleLabel.font = Fonts.lHeavy.font
        titleLabel.textColor = Colors.white

        // MARK: subtitleLabel style

        subtitleLabel.font = Fonts.lRegular.font
        subtitleLabel.textColor = Colors.white

        // MARK: descriptionLabel style

        descriptionLabel.font = Fonts.mRegular.font
        descriptionLabel.textColor = Colors.white
        descriptionLabel.numberOfLines = 0

        // MARK: signUpButton style

        signUpButton.layer.cornerRadius = Paddings.xxxs
        signUpButton.setTitleColor(Colors.brandPrimary, for: .normal)
        signUpButton.titleLabel?.font = Fonts.sHeavy.font
        signUpButton.backgroundColor = Colors.white
        signUpButton.semanticContentAttribute = .forceRightToLeft
        signUpButton.contentHorizontalAlignment = .left
        signUpButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16.0, bottom: 0.0, right: -16.0)

        // MARK: loginButton style

        loginButton.setTitleColor(Colors.white, for: .normal)
        loginButton.titleLabel?.font = Fonts.xsRegular.font
        loginButton.backgroundColor = Colors.brandPrimary
        loginButton.layer.cornerRadius = Paddings.xxxs

        // MARK: titleStackView style

        titleStackView.axis = .vertical
        titleStackView.alignment = .leading
        titleStackView.spacing = Paddings.nano

        // MARK: buttonStackView style

        buttonStackView.axis = .vertical
        buttonStackView.alignment = .fill
        buttonStackView.spacing = Paddings.xxxs
    }
}
