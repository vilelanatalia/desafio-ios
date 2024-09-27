import Foundation

enum DateFormatType {
    case fullDate
    case timeOnly
    case prefixDate

    var dateFormat: String {
        switch self {
        case .fullDate:
            "EEEE - d 'de' MMMM"
        case .timeOnly:
            "HH:mm"
        case .prefixDate:
            "EEEE - MM/dd/yyyy"
        }
    }
}

enum Formatters {
    static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "pt_BR")
        return dateFormatter
    }()
}

func formatDate(from isoDate: String?, formatType: DateFormatType) -> String? {
    guard
        let isoDate = isoDate,
        let date = Formatters.isoFormatter.date(from: isoDate)
    else { return nil }

    Formatters.dateFormatter.dateFormat = formatType.dateFormat

    return Formatters.dateFormatter.string(from: date).capitalized
}
