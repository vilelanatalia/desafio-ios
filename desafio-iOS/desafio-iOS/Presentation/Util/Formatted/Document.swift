import Foundation

enum DocumentType: String {
    case cpf = "CPF"
    case cnpj = "CNPJ"

    var mask: String {
        switch self {
        case .cpf:
            "###.###.###-##"
        case .cnpj:
            "##.###.###/####-##"
        }
    }
}

func documentFormatter(_ documentValue: String, type: DocumentType) -> String {
    let cleanValue = documentValue.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

    var result = ""
    var index = cleanValue.startIndex

    for value in type.mask where index < cleanValue.endIndex {
        if value == "#" {
            result.append(cleanValue[index])
            index = cleanValue.index(after: index)
        } else {
            result.append(value)
        }
    }

    return result
}
