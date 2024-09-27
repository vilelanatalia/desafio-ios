import Foundation

func formatAccount(_ agency: String, _ account: String) -> String {
    let formattedAccount = account.count > 1 ? "\(account.dropLast())-\(account.suffix(1))" : account

    return "Agência \(agency) - Conta \(formattedAccount)"
}
