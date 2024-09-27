import Foundation

protocol PasswordViewModelProtocol {
    var passwordValue: String { get set }

    var onButtonStateChange: ((Bool) -> Void)? { get set }
    var onLoadingStateChange: ((Bool) -> Void)? { get set }

    func passwordValidation(_ passwordValue: String) -> Bool
    func login() async throws
}

final class PasswordViewModel: PasswordViewModelProtocol {
    private let authUseCase: AuthUseCase
    private let cpf: String

    init(authUseCase: AuthUseCase = AuthUseCase(), cpf: String) {
        self.authUseCase = authUseCase
        self.cpf = cpf
    }

    var onButtonStateChange: ((Bool) -> Void)?

    var onLoadingStateChange: ((Bool) -> Void)?

    @MainActor
    func login() async throws {
        onLoadingStateChange?(true)

        let response = try await authUseCase.execute(cpf: cpf, password: passwordValue)
        AuthManager.shared.token = response.token
        onLoadingStateChange?(false)
    }

    var passwordValue: String = "" {
        didSet {
            let isValid = passwordValidation(passwordValue)
            onButtonStateChange?(isValid)
        }
    }

    func passwordValidation(_ passwordValue: String) -> Bool {
        return passwordValue.count >= 6
    }
}
