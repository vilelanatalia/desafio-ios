import UIKit

class IntroView: UIView {
    let constants = IntroViewConstants()

    // TODO: Update image position
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "image"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var heavyTitleLabel: UILabel = createLabel(for: .largeHeavyTitle, text: constants.titleText)
    private lazy var regularTitleLabel: UILabel = createLabel(for: .largeRegularTitle, text: constants.susbtitleText)
    private lazy var descriptionLabel: UILabel = createLabel(for: .blankRegularSubtitle, text: constants.descriptionText)

    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [heavyTitleLabel, regularTitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = Paddings.quarck

        return stackView
    }()

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textStackView, buttonStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing

        return stackView
    }()
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading

        stackView.spacing = Paddings.xxxs
        return stackView
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
        addSubview(mainStackView)

    }
    
    func setupConstraints() {
        let safeGuide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Paddings.xxxs),
            mainStackView.leadingAnchor.constraint(equalTo: safeGuide.leadingAnchor, constant: Paddings.xxs),
            mainStackView.trailingAnchor.constraint(equalTo: safeGuide.trailingAnchor, constant: -Paddings.xxs),
            mainStackView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -Paddings.xxs),

            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 360),
            imageView.heightAnchor.constraint(equalToConstant: 360),

            buttonStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),

            signUpButton.heightAnchor.constraint(equalToConstant: 64),
            loginButton.heightAnchor.constraint(equalToConstant: 64)
        ])
    }

    func setupStyle() {
        backgroundColor = Colors.brandPrimary


        // MARK: descriptionLabel style

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

        // MARK: buttonStackView style

        buttonStackView.axis = .vertical
        buttonStackView.alignment = .fill
        buttonStackView.spacing = Paddings.xxxs
    }
}
