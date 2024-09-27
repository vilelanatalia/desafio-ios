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

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [passwordTextField, visibilityButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var passwordTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

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

    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()

        // Alterna o ícone do botão
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
        addSubview(passwordTitleLabel)
        addSubview(textStackView)
        addSubview(forgotPasswordButton)
        addSubview(nextButton)
    }

    func setupConstraints() {
        let safeGuide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            // Constraints dos elementos dentro da stack
            passwordTitleLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: Paddings.xxs),
            passwordTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxs),
            passwordTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxs),

            textStackView.topAnchor.constraint(equalTo: passwordTitleLabel.bottomAnchor, constant: Paddings.xs),
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxs),
            textStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxs),

            forgotPasswordButton.topAnchor.constraint(equalTo: textStackView.bottomAnchor, constant: Paddings.md),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxs),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxs),

            // Next button constraints
            nextButton.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor, constant: -Paddings.xxs),
            nextButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxs),
            nextButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxs),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
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

        // MARK: passwordTitleLabel style

        passwordTitleLabel.text = constants.passwordTitleText
        passwordTitleLabel.font = Fonts.mHeavy.font

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
