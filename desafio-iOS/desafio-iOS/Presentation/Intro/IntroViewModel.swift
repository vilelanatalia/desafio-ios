import Foundation

protocol IntroViewModelProtocol {
    var onLogginButtonPressed: (() -> Void)? { get set }
}

final class IntroViewModel: IntroViewModelProtocol {
    var onLogginButtonPressed: (() -> Void)?
}
