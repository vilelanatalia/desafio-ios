import Foundation

protocol TransferDetailsRepositoryProtocol {
    func getTransferDetails(userId: String) async throws -> TransferDetailsResponseModel
}

final class TransferDetailsRepository: TransferDetailsRepositoryProtocol {
    private let baseURL = "\(Environment.baseUrl)/challenge/details/"

    private let client: NetworkClientProtocol
    private let authManager: AuthManagerProtocol

    init(client: NetworkClientProtocol, authManager: AuthManagerProtocol) {
        self.client = client
        self.authManager = authManager
    }

    func getTransferDetails(userId: String) async throws -> TransferDetailsResponseModel {
        guard let url = URL(string: "\(baseURL)\(userId)") else {
            throw NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        guard let token = authManager.token else {
            throw NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No token"])
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(PropertyList.ApiKey, forHTTPHeaderField: "apikey")
        request.addValue(token, forHTTPHeaderField: "token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await client.fetchData(from: request)

            if let httpResponse = response as? HTTPURLResponse, !(200 ... 299).contains(httpResponse.statusCode) {
                throw NSError(
                    domain: "",
                    code: httpResponse.statusCode,
                    userInfo: [NSLocalizedDescriptionKey: "HTTP Error: \(httpResponse.statusCode)"]
                )
            }

            let transaction = try JSONDecoder().decode(TransferDetailsResponseModel.self, from: data)
            return transaction
        } catch {
            throw error
        }
    }
}
