import XCTest

@testable import desafio_iOS

final class BankStatementRepositoryTests: XCTestCase {
    typealias SUT = BankStatementRepository

    private var sut: SUT!
    private var mockClient: MockNetworkClient!
    private var mockAuthManager: MockAuthManager!

    override func setUp() {
        super.setUp()
        mockClient = .init()
        mockAuthManager = .init()
        sut = .init(client: mockClient, authManager: mockAuthManager)
    }

    override func tearDown() {
        super.tearDown()
        mockClient = nil
        sut = nil
    }

    func test_WhenGetTransferDetails_ThenSuccess_ShouldReceiveExpectedResponse() async throws {
        mockAuthManager.token = "foobar"
        mockClient.mockData = Data(
            """
            {
              "results": [
                {
                  "items": [
                    {
                      "id": "foobar",
                      "description": "Compra de produtos eletrônicos",
                      "label": "Compra aprovada",
                      "entry": "DEBIT",
                      "amount": 32131,
                      "name": "Natalia",
                      "dateEvent": "2024-02-01T08:15:17Z",
                      "status": "COMPLETED"
                    }
                  ],
                  "date": "2024-09-10"
                }
              ],
              "itemsTotal": 1
            }
            """.utf8)

        mockClient.mockResponse = HTTPURLResponse(
            url: URL(string: "http://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let list = try await sut.getListTransaction()

        let firstItem = try XCTUnwrap(list.results.first?.items.first)
        XCTAssertEqual(list.results.count, 1)
        XCTAssertEqual(list.itemsTotal, 1)
        XCTAssertEqual(firstItem.id, "foobar")
        XCTAssertEqual(firstItem.amount, 32131)
    }
}
