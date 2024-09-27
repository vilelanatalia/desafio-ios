import Foundation
import UIKit

protocol BankStatementViewModelProtocol {
    var onBankStatementFetched: ((BankStatementResponseModel) -> Void)? { get set }
    var bankStatement: BankStatementResponseModel { get set }
    var selectedSegmentIndex: Int { get set }
    var onSegmentChange: ((Int) -> Void)? { get set }
    var transactionsByDate: [String: [ResultItem]] { get set }
    var transactionsDatesSorted: [String] { get set }

    func getList() async throws
    func orderByDate()
    func changeSegment(to index: Int)
    func getTransactionLabel(label: String?) -> TransactionLabel?
}

final class BankStatementViewModel: BankStatementViewModelProtocol {
    private let bankStatementUseCase: BankStatementUseCase

    init(bankStatementUseCase: BankStatementUseCase) {
        self.bankStatementUseCase = bankStatementUseCase
    }

    var onBankStatementFetched: ((BankStatementResponseModel) -> Void)?

    var bankStatement: BankStatementResponseModel = .empty {
        didSet {
            onBankStatementFetched?(bankStatement)
        }
    }

    var selectedSegmentIndex: Int = 0 {
        didSet {
            onSegmentChange?(selectedSegmentIndex)
        }
    }

    var onSegmentChange: ((Int) -> Void)?

    func changeSegment(to index: Int) {
        selectedSegmentIndex = index
    }

    var transactionsByDate: [String: [ResultItem]] = [:]

    var transactionsDatesSorted: [String] = []

    let dateFormatter = ISO8601DateFormatter()

    @MainActor
    func getList() async throws {
        let response = try await bankStatementUseCase.getList()
        bankStatement = response
        orderByDate()
    }

    func orderByDate() {
        for transaction in bankStatement.results {
            guard let date = transaction.items.first?.dateEvent else { return }

            if transactionsByDate[date] != nil {
                transactionsByDate[date]?.append(transaction)
            } else {
                transactionsByDate[date] = [transaction]
            }
        }

        transactionsDatesSorted = transactionsByDate.keys.sorted {
            guard let date1 = dateFormatter.date(from: $0), let date2 = dateFormatter.date(from: $1) else {
                return false
            }
            return date1 > date2
        }
    }

    func getTransactionLabel(label: String?) -> TransactionLabel? {
        guard let label else { return nil }

        return TransactionLabel(rawValue: label)
    }
}

enum TransactionLabel: String, CaseIterable {
    case paymentCompleted = "Pagamento efetuado"
    case transferCompleted = "Transferência recebida"
    case debitCompleted = "Débito automático"
    case purchaseCompleted = "Compra aprovada"

    var symbol: String {
        switch self {
        case .transferCompleted:
            return "arrow-up"
        case .paymentCompleted, .debitCompleted, .purchaseCompleted:
            return "arrow-down"
        }
    }

    var color: UIColor {
        switch self {
        case .paymentCompleted, .debitCompleted, .transferCompleted, .purchaseCompleted:
            return Colors.labelPrimary!
        }
    }
}
