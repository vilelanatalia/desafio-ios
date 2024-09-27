import Foundation

protocol NetworkClientProtocol {
    func fetchData(from urlRequest: URLRequest) async throws -> (Data, URLResponse)
}

final class NetworkClient: NetworkClientProtocol {
    func fetchData(from urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(for: urlRequest)
    }
}
