import Foundation
import UIKit

enum Fonts {
    case xxsRegular
    case xsRegular
    case sRegular
    case mRegular
    case lRegular

    case xsHeavy
    case sHeavy
    case mHeavy
    case lHeavy

    var font: UIFont {
        switch self {
        case .xxsRegular:
            return UIFont(name: "Avenir-Roman", size: 12)!
        case .xsRegular:
            return UIFont(name: "Avenir-Roman", size: 14)!
        case .sRegular:
            return UIFont(name: "Avenir-Roman", size: 16)!
        case .mRegular:
            return UIFont(name: "Avenir-Roman", size: 22)!
        case .lRegular:
            return UIFont(name: "Avenir-Roman", size: 28)!
        case .xsHeavy:
            return UIFont(name: "Avenir-Heavy", size: 14)!
        case .sHeavy:
            return UIFont(name: "Avenir-Heavy", size: 16)!
        case .mHeavy:
            return UIFont(name: "Avenir-Heavy", size: 22)!
        case .lHeavy:
            return UIFont(name: "Avenir-Heavy", size: 28)!
        }
    }
}
