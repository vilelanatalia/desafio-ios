import Foundation

enum Environment {
    static let baseUrl: String = "https://api.challenge.stage.cora.com.br"
}

enum PropertyList {
    static let ApiKey: String = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
}
