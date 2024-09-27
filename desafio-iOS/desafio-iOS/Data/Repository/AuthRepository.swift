import Foundation
import SwiftUI

final class AuthRepository: AuthRepositoryProtocol {
    private let baseURL = "\(Environment.baseUrl)/challenge/auth"

    func authenticate(cpf: String, password: String) async throws -> AuthResponseModel {
        let sanitizedCPF = cpf.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "")

        guard let url = URL(string: baseURL) else {
            throw NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(PropertyList.ApiKey, forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = AuthRequestModel(cpf: sanitizedCPF, password: password)

        do {
            let jsonData = try JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            if let httpResponse = response as? HTTPURLResponse, !(200 ... 299).contains(httpResponse.statusCode) {
                throw NSError(
                    domain: "",
                    code: httpResponse.statusCode,
                    userInfo: [NSLocalizedDescriptionKey: "HTTP Error: \(httpResponse.statusCode)"]
                )
            }

            let responseModel = try JSONDecoder().decode(AuthResponseModel.self, from: data)
            return responseModel
        }
    }
}
