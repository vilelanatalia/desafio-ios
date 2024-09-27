import Foundation

@testable import desafio_iOS

final class MockNetworkClient: NetworkClientProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?

    func fetchData(from _: URLRequest) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        guard let data = mockData, let response = mockResponse else {
            throw NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "No mock data or response set"])
        }
        return (data, response)
    }
}
