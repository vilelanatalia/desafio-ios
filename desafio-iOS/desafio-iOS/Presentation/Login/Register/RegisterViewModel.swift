import Combine
import Foundation

protocol RegisterViewModelProtocol {
    var registerValue: String { get set }
    var onFormattedTextChange: ((String) -> Void)? { get set }
    var onButtonStateChange: ((Bool) -> Void)? { get set }

    func registerValidation(_ registerValue: String) -> Bool
}

final class RegisterViewModel: RegisterViewModelProtocol {
    private let authUseCase: AuthUseCase

    init(authUseCase: AuthUseCase = AuthUseCase()) {
        self.authUseCase = authUseCase
    }

    var onFormattedTextChange: ((String) -> Void)?
    var onButtonStateChange: ((Bool) -> Void)?

    var registerValue: String = "" {
        didSet {
            let formattedRegister = documentFormatter(registerValue, type: .cpf)

            onFormattedTextChange?(formattedRegister)

            let isValid = registerValidation(formattedRegister)
            onButtonStateChange?(isValid)
        }
    }

    func registerValidation(_ registerValue: String) -> Bool {
        return registerValue.count == 14
    }
}
