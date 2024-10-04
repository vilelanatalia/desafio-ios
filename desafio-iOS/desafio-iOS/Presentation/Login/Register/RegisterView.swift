import UIKit

class RegisterView: UIView {
    let viewModel: RegisterViewModelProtocol
    let constants = RegisterViewConstants()

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

    var navigationBarAppearance: UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance()
        return appearance
    }

    // MARK: Private properties
    /// Label
    private lazy var welcomeLabel: UILabel = createLabel(for: .regularSubtitle, text: constants.welcomeText)
    private lazy var registerLabel: UILabel = createLabel(for: .heavyTitle, text: constants.registerText)

    /// StackView
    private lazy var headerStackView: UIStackView = createStackView(for: .vertical, arrangedSubviews: [welcomeLabel, registerLabel], spacing: Paddings.nano)
    private lazy var registerStackView: UIStackView = createStackView(for: .vertical, arrangedSubviews: [headerStackView, registerTextField], spacing: Paddings.xs)
    private lazy var mainStackView: UIStackView = createStackView(for: .main, arrangedSubviews: [registerStackView, nextButton])


    //MARK: Public properties

    // TODO: - TextField, refactor
    var registerTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Digite seu CPF"

        return textField
    }()
    // TODO: - Button, refactor
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(constants.nextTextButton, for: .normal)
        button.isEnabled = false

        return button
    }()
}

extension RegisterView: ViewCode {
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

          // MARK: nextButton constraints
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
