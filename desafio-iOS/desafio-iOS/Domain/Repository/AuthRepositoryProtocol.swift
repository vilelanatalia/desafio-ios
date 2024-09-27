protocol AuthRepositoryProtocol {
    func authenticate(cpf: String, password: String) async throws -> AuthResponseModel
}
