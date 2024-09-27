import Foundation

struct BankStatementResponseModel: Codable {
    let results: [ResultItem]
    let itemsTotal: Int
}

struct ResultItem: Codable {
    let items: [TransactionItem]
    let date: String
}

struct TransactionItem: Codable, Identifiable {
    let id: String
    let description: String
    let label: String
    let entry: String
    let amount: Int
    let name: String
    let dateEvent: String
    let status: String
}

extension BankStatementResponseModel {
    static let empty: BankStatementResponseModel = .init(results: [], itemsTotal: 0)
}

extension ResultItem {
    static let empty: ResultItem = .init(items: [], date: "")
}

extension TransactionItem {
    static let empty: TransactionItem = .init(id: "",
                                              description: "",
                                              label: "",
                                              entry: "",
                                              amount: 0,
                                              name: "",
                                              dateEvent: "",
                                              status: "")
}
