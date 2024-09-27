import UIKit

class RegisterView: UIView {
    let viewModel: RegisterViewModelProtocol
    let constants = RegisterViewConstants()

    // View standard configuration
    var navigationBarAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        return appearance
    }

    // MARK: - UI Components

    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = constants.welcomeText
        return label
    }()

    private lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var registerTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu CPF"

        return textField
    }()

    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(constants.nextTextButton, for: .normal)
        button.isEnabled = false

        return button
    }()

    // MARK: - Init

    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegisterView: ViewCode {
    func addSubviews() {
        addSubview(welcomeLabel)
        addSubview(registerLabel)
        addSubview(registerTextField)
        addSubview(nextButton)
    }

    func setupConstraints() {
        let safeGuide = safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            // MARK: welcomeLabel constraints

            welcomeLabel.topAnchor.constraint(equalTo: safeGuide.topAnchor, constant: Paddings.xxs),
            welcomeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxs),

            // MARK: registerLabel constraints

            registerLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: Paddings.nano),
            registerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxs),

            // MARK: registerTextField constraints

            registerTextField.topAnchor.constraint(equalTo: registerLabel.bottomAnchor, constant: Paddings.xs),
            registerTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Paddings.xxs),
            registerTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Paddings.xxs),

            // MARK: nextButton constraints

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

        // MARK: welcomeLabel style

        welcomeLabel.font = Fonts.sRegular.font
        welcomeLabel.textColor = Colors.grayscale3

        // MARK: registerLabel style

        registerLabel.text = constants.registerText
        registerLabel.font = Fonts.mHeavy.font

        // MARK: registerTextField style

        registerTextField.font = Fonts.mRegular.font
        registerTextField.keyboardType = .numberPad
        registerTextField.borderStyle = .none

        // MARK: nextButton style

        nextButton.titleLabel?.font = Fonts.xsHeavy.font
        nextButton.setTitleColor(Colors.white, for: .normal)
        nextButton.layer.cornerRadius = Paddings.xxxs
        nextButton.semanticContentAttribute = .forceRightToLeft
        nextButton.tintColor = Colors.white
        nextButton.backgroundColor = Colors.grayscale3
        nextButton.contentHorizontalAlignment = .left
        nextButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 16.0, bottom: 0.0, right: -16.0)
    }
}
