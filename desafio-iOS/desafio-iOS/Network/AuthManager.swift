import Foundation

protocol AuthManagerProtocol {
    var token: String? { get }
}

class AuthManager: AuthManagerProtocol {
    static let shared: AuthManager = .init()
    var token: String? // TODO: store this in keychain instead

    init() {}
}
