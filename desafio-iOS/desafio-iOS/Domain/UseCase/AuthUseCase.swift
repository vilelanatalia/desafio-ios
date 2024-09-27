protocol AuthUseCaseProtocol {
    func execute(cpf: String, password: String) async throws -> AuthResponseModel
}

final class AuthUseCase: AuthUseCaseProtocol {
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
    }

    func execute(cpf: String, password: String) async throws -> AuthResponseModel {
        return try await repository.authenticate(cpf: cpf, password: password)
    }
}
