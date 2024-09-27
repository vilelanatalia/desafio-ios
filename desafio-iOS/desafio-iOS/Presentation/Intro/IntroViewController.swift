import UIKit

class IntroViewController: UIViewController {
    private let viewModel: IntroViewModel
    private let introView = IntroView()

    init(viewModel: IntroViewModel = IntroViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view = introView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationAppearance()
        introView.setup()
        configBindings()
        buttonAction()
    }

    // TODO: Not working, using buttonAction() for now
    private func configBindings() {
        viewModel.onLogginButtonPressed = { [weak self] in

            guard let self = self else { return }
            introView.loginButton.addTarget(self, action: #selector(self.nextButtonTapped), for: .touchUpInside)
        }
    }

    private func buttonAction() {
        introView.loginButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }

    @objc private func nextButtonTapped() {
        let nextViewController = RegisterViewController(viewModel: RegisterViewModel())
        navigationController?.pushViewController(nextViewController, animated: true)
    }

    func navigationAppearance() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
    }
}
