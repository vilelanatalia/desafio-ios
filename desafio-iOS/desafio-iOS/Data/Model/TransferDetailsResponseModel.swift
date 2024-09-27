import Foundation

struct TransferDetailsResponseModel: Codable {
    let description: String
    let label: String
    let amount: Int
    let counterPartyName: String
    let id: String
    let dateEvent: String
    let recipient: UserDetails
    let sender: UserDetails
    let status: String
}

struct UserDetails: Codable {
    let bankName: String
    let bankNumber: String
    let documentNumber: String
    let documentType: String
    let accountNumberDigit: String
    let agencyNumberDigit: String
    let agencyNumber: String
    let name: String
    let accountNumber: String
}

extension TransferDetailsResponseModel {
    static let empty: TransferDetailsResponseModel =
        .init(description: "", label: "", amount: 0, counterPartyName: "", id: "", dateEvent: "",
              recipient: UserDetails.empty, sender: UserDetails.empty, status: "")
}

extension UserDetails {
    static let empty: UserDetails = .init(
        bankName: "", bankNumber: "", documentNumber: "", documentType: "",
        accountNumberDigit: "", agencyNumberDigit: "", agencyNumber: "", name: "", accountNumber: ""
    )
}
