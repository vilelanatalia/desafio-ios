import Foundation
import UIKit

class PasswordViewController: UIViewController {
    private var viewModel: PasswordViewModelProtocol
    private lazy var passwordView: PasswordView = .init()
    private var constants = PasswordConstants()

    init(viewModel: PasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = passwordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarAppearance()
        passwordView.setup()
        configBindings()
        registerObserver()
        buttonAction()
    }

    private func configBindings() {
        viewModel.onButtonStateChange = { [weak self] isEnabled in
            self?.passwordView.updateButton(isEnabled: isEnabled)
        }
    }

    private func registerObserver() {
        passwordView.passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        view.addGestureRecognizer(UITapGestureRecognizer(
            target: self,
            action: #selector(UIInputViewController.dismissKeyboard)
        )
        )
    }

    private func buttonAction() {
        passwordView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func nextButtonTapped() {
        guard passwordView.nextButton.isEnabled else { return }
        Task {
            do {
                try await viewModel.login()

                let nextViewController = BankStatementViewController(
                    viewModel: BankStatementViewModel(bankStatementUseCase: BankStatementUseCase())
                )
                navigationController?.pushViewController(nextViewController, animated: true)
            } catch {
                // TODO: display error
            }
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        viewModel.passwordValue = textField.text ?? ""
    }

    func navigationBarAppearance() {
        navigationItem.title = constants.navigationTitle

        let appearance = passwordView.navigationBarAppearance
        navigationController?.navigationBar.tintColor = Colors.brandPrimary

        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    

}
