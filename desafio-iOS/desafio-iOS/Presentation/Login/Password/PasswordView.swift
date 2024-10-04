import UIKit

class PasswordView: UIView {
    let constants = PasswordConstants()

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var navigationBarAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()

        return appearance
    }
    // MARK: - UI Components

    private lazy var passwordTitleLabel: UILabel = createLabel(for: .heavyTitle, text: constants.passwordTitleText)

    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left

        return button
    }()

    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.placeholder = "Digite sua senha"

        return textField
    }()

    private lazy var visibilityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        return button

    }()

    // MARK: Stack Views

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordTextField, visibilityButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordTitleLabel, textStackView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 32

        return stackView
    }()

    lazy var passwordStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStackView, forgotPasswordButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 48

        return stackView
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordStackView, nextButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing

        return stackView
    }()

    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()

        let buttonImage = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        visibilityButton.setImage(UIImage(systemName: buttonImage), for: .normal)
    }

    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false

        return button
    }()

    func updateButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.backgroundColor = isEnabled ? Colors.brandPrimary : Colors.grayscale3
    }
}

extension PasswordView: ViewCode {
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

            textStackView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),


            nextButton.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: Paddings.lg)

        ])
    }

    func setupStyle() {
        backgroundColor = Colors.white

        // MARK: navigationBarAppearance

        navigationBarAppearance.backgroundColor = Colors.grayscale1!
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.grayscale2!]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.grayscale2!]

        // MARK: textStackView style

        textStackView.axis = .horizontal
        textStackView.alignment = .leading
        textStackView.distribution = .fillProportionally

        // MARK: forgotPasswordButton style

        forgotPasswordButton.setTitle(constants.forgotPasswordText, for: .normal)
        forgotPasswordButton.titleLabel?.font = Fonts.xsRegular.font
        forgotPasswordButton.setTitleColor(Colors.brandPrimary, for: .normal)

        // MARK: passwordTextField style

        passwordTextField.font = Fonts.mRegular.font
        passwordTextField.borderStyle = .none

        // MARK: visibilityButton style

        visibilityButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        visibilityButton.tintColor = Colors.brandPrimary

        // MARK: nextButton style

        nextButton.setTitle(constants.nextTextButton, for: .normal)
        nextButton.titleLabel?.font = Fonts.xsHeavy.font
        nextButton.setTitleColor(Colors.white, for: .normal)
        nextButton.layer.cornerRadius = Paddings.micro
        nextButton.semanticContentAttribute = .forceRightToLeft
        nextButton.tintColor = Colors.white
        nextButton.backgroundColor = Colors.grayscale3
        nextButton.contentHorizontalAlignment = .left
        nextButton.titleEdgeInsets = UIEdgeInsets(top: Paddings.none,
                                                  left: Paddings.xxxs,
                                                  bottom: Paddings.none,
                                                  right: -Paddings.xxxs)
    }
}
