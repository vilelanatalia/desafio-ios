import Foundation
import SwiftUI

protocol BankStatementRepositoryProtocol {
    func getListTransaction() async throws -> BankStatementResponseModel
}

final class BankStatementRepository: BankStatementRepositoryProtocol {
    private let baseURL = "\(Environment.baseUrl)/challenge/list"

    private let client: NetworkClientProtocol
    private let authManager: AuthManagerProtocol

    init(client: NetworkClientProtocol, authManager: AuthManagerProtocol) {
        self.client = client
        self.authManager = authManager
    }

    func getListTransaction() async throws -> BankStatementResponseModel {
        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        var request = URLRequest(url: url)
        guard let token = authManager.token else {
            throw NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "No token"])
        }
        request.httpMethod = "GET"
        request.addValue(PropertyList.ApiKey, forHTTPHeaderField: "apikey")
        request.addValue(token, forHTTPHeaderField: "token")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await client.fetchData(from: request)

            // Valida o status HTTP da resposta
            if let httpResponse = response as? HTTPURLResponse, !(200 ... 299).contains(httpResponse.statusCode) {
                throw NSError(
                    domain: "",
                    code: httpResponse.statusCode,
                    userInfo: [NSLocalizedDescriptionKey: "HTTP Error: \(httpResponse.statusCode)"]
                )
            }
            // Decodifica a resposta
            let responseModel = try JSONDecoder().decode(BankStatementResponseModel.self, from: data)
            return responseModel
        }
    }
}
