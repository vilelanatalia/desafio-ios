import Foundation
import UIKit

enum LabelType {
    /// Fontsize: 28, HexColor: #FFFFFF
    case largeHeavyTitle

    /// Fontsize: 28, HexColor: #FFFFFF
    case largeRegularTitle

    /// Fontsize: 22, HexColor: #3B3B3B
    case heavyTitle

    /// Fontsize: 22, HexColor: #3B3B3B
    case regularTitle

    /// Fontsize: 12, HexColor: #3B3B3B
    case regularFootnote

    /// Fontsize: 16, HexColor: #6B7076
    case regularSubtitle

    /// Fontsize: 16, HexColor: #FFFFFF
    case blankRegularSubtitle

    /// Fontsize: 16, HexColor: #3B3B3B
    case heavyBody

    /// Fontsize: 14, HexColor: #3B3B3B
    case regularBody

    /// Fontsize: 16, HexColor: #1A93DA
    case contrastHeavyBody

    /// Fontsize: 14, HexColor: #1A93DA
    case contrastRegularBody

    /// Fontsize: 14, HexColor: #6B7076
    case regularSupport

    /// Fontsize: 14, HexColor: #FE3E6D
    case hightlightSupport

}

func createLabel(for type: LabelType, text: String? = nil) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.numberOfLines = 0

    switch type {

    case .largeHeavyTitle:
        label.font = Fonts.lHeavy.font
        label.textColor = Colors.white

    case .largeRegularTitle:
        label.font = Fonts.lRegular.font
        label.textColor = Colors.white

    case .heavyTitle:
        label.font = Fonts.mHeavy.font
        label.textColor = Colors.grayscale5
    case .regularTitle:
        label.font = Fonts.mRegular.font
        label.textColor = Colors.grayscale5

    case .regularSubtitle:
        label.font = Fonts.sRegular.font
        label.textColor = Colors.grayscale2

    case .blankRegularSubtitle:
        label.font = Fonts.sRegular.font
        label.textColor = Colors.white

    case .regularFootnote:
        label.font = Fonts.xxsRegular.font
        label.textColor = Colors.grayscale2

    case .heavyBody:
        label.font = Fonts.sHeavy.font
        label.textColor = Colors.grayscale5
    case .regularBody:
        label.font = Fonts.xsRegular.font
        label.textColor = Colors.grayscale5
    case .contrastHeavyBody:
        label.font = Fonts.sHeavy.font
        label.textColor = Colors.labelPrimary
    case .contrastRegularBody:
        label.font = Fonts.xsRegular.font
        label.textColor = Colors.labelPrimary

    case .regularSupport:
        label.font = Fonts.xsRegular.font
        label.textColor = Colors.grayscale2
    case .hightlightSupport:
        label.font = Fonts.xsRegular.font
        label.textColor = Colors.brandPrimary


    }
    return label
}
