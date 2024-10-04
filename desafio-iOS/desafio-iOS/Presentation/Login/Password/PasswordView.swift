import UIKit

class PasswordView: UIView {
    let constants = PasswordConstants()

    // MARK: - Init

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

    // MARK: Private properties
    /// Label
    private lazy var passwordTitleLabel: UILabel = createLabel(for: .heavyTitle, text: constants.passwordTitleText)

    /// StackView
    private lazy var textStackView: UIStackView = createStackView(for: .horizontal,
                                                                  arrangedSubviews: [passwordTextField, visibilityButton])

    private lazy var headerStackView: UIStackView = createStackView(for: .vertical,
                                                                    arrangedSubviews: [passwordTitleLabel, textStackView],
                                                                    spacing: Paddings.xs)

    private lazy var mainStackView: UIStackView = createStackView(for: .main,
                                                                  arrangedSubviews: [passwordStackView, nextButton])

    lazy var passwordStackView: UIStackView = createStackView(for: .vertical,
                                                              arrangedSubviews: [headerStackView, forgotPasswordButton],
                                                              spacing: Paddings.md)


    // MARK: Public Properties

    /// Textfield
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.placeholder = "Digite sua senha"

        return textField
    }()

    /// Button
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .left

        return button
    }()

    lazy var visibilityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)

        return button
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false

        return button
    }()

    @objc private func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()

        let buttonImage = passwordTextField.isSecureTextEntry ? "eye" : "eye.slash"
        visibilityButton.setImage(UIImage(systemName: buttonImage), for: .normal)
    }
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

//        textStackView.axis = .horizontal
//        textStackView.alignment = .leading
//        textStackView.distribution = .fillProportionally

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
