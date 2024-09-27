import Foundation

protocol TransferDetailsViewModelProtocol {
    var transferDetails: TransferDetailsResponseModel { get set }
    var onTransferDetailsFetched: ((TransferDetailsResponseModel) -> Void)? { get set }

    func getDocumentType(document: String?) -> DocumentType?
    func getTransferDetails() async throws
}

final class TransferDetailsViewModel: TransferDetailsViewModelProtocol {
    private let transferDetailsUseCase: TransferDetailsUseCaseProtocol
    private let userID: String?

    init(transferDetailsUseCase: TransferDetailsUseCaseProtocol, userID: String) {
        self.transferDetailsUseCase = transferDetailsUseCase
        self.userID = userID
    }

    var onTransferDetailsFetched: ((TransferDetailsResponseModel) -> Void)?

    var transferDetails: TransferDetailsResponseModel = .empty {
        didSet {
            onTransferDetailsFetched?(transferDetails)
        }
    }

    @MainActor
    func getTransferDetails() async throws {
        let response = try await transferDetailsUseCase.getTransferDetails(userId: userID!)
        transferDetails = response
    }

    func getDocumentType(document: String?) -> DocumentType? {
        guard let document else { return nil }

        return DocumentType(rawValue: document)
    }
}
