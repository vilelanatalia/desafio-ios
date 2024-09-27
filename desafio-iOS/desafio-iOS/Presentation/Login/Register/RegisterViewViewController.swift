import UIKit

class RegisterViewController: UIViewController {
    private var viewModel: RegisterViewModel
    private lazy var loginView: RegisterView = .init(viewModel: viewModel)

    init(viewModel: RegisterViewModel = RegisterViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.setup()
        configBindings()
        registerObserver()
        buttonAction()
        navigationAppearance()
    }

    private func configBindings() {
        viewModel.onFormattedTextChange = { [weak self] registerValue in
            self?.loginView.registerTextField.text = registerValue
        }

        viewModel.onButtonStateChange = { [weak self] isEnabled in
            self?.updateButton(isEnabled: isEnabled)
        }
    }

    private func registerObserver() {
        loginView.registerTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        )
    }

    private func buttonAction() {
        loginView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func nextButtonTapped() {
        if loginView.nextButton.isEnabled {
            let nextViewController = PasswordViewController(viewModel: PasswordViewModel(cpf: viewModel.registerValue))
            navigationController?.pushViewController(nextViewController, animated: true)
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.registerValue = textField.text ?? ""
    }

    func updateButton(isEnabled: Bool) {
        loginView.nextButton.isEnabled = isEnabled
        loginView.nextButton.backgroundColor = isEnabled ? Colors.brandPrimary : Colors.grayscale3
    }

    func navigationAppearance() {
        let appearance = loginView.navigationBarAppearance
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        navigationItem.title = "Login Cora"
        navigationController?.navigationBar.tintColor = Colors.brandPrimary
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
