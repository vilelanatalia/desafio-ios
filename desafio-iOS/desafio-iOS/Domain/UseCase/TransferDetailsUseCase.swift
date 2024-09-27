import Foundation

protocol TransferDetailsUseCaseProtocol {
    func getTransferDetails(userId: String) async throws -> TransferDetailsResponseModel
}

final class TransferDetailsUseCase: TransferDetailsUseCaseProtocol {
    private let repository: TransferDetailsRepositoryProtocol

    init(repository: TransferDetailsRepositoryProtocol = TransferDetailsRepository(client: NetworkClient(), authManager: AuthManager.shared)) {
        self.repository = repository
    }

    func getTransferDetails(userId: String) async throws -> TransferDetailsResponseModel {
        return try await repository.getTransferDetails(userId: userId)
    }
}
