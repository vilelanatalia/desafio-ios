import Foundation

func formatAmount(value: Int?) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    formatter.groupingSeparator = "."
    formatter.decimalSeparator = ","

    let number = NSNumber(value: Double(value!) / 100.0)
    return formatter.string(from: number) ?? "0,00"
}
