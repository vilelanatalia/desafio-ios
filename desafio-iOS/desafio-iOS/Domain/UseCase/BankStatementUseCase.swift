import Foundation

protocol BankStatementUseCaseProtocol {
    func getList() async throws -> BankStatementResponseModel
}

final class BankStatementUseCase: BankStatementUseCaseProtocol {
    private let repository: BankStatementRepositoryProtocol

    init(
        repository: BankStatementRepositoryProtocol = BankStatementRepository(
            client: NetworkClient(),
            authManager: AuthManager.shared
        )
    ) {
        self.repository = repository
    }

    func getList() async throws -> BankStatementResponseModel {
        return try await repository.getListTransaction()
    }
}
