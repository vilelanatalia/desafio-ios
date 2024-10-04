import UIKit

enum StackViewType {
    case vertical
    case horizontal
    case main
    case horizontalMain
}

func createStackView(for type: StackViewType, arrangedSubviews: [UIView], spacing: CGFloat? = nil) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.translatesAutoresizingMaskIntoConstraints = false

    switch type {

    case .vertical:
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = spacing ?? 0.0

    case .horizontal:
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = spacing ?? 0.0

    case .main:
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing

    case .horizontalMain:
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing



    }

    return stackView

}
