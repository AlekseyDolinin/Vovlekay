import Foundation

class ErrorParser: ObservableObject {
    
    static let shared = ErrorParser()
        
    func parse(input: Response_) {
        if let data = input.data_ {
            let json = JSON(data)
            if let detail = json["detail"].string {
                let textError = getTextError(detail: detail)
                print("textError: \(textError)")
            }
        }
    }
    
    func parse(detail: String) -> String {
        return getTextError(detail: detail)
    }
}



extension ErrorParser {
    
    private func getTextError(detail: String) -> String {
        
        switch detail {
            
        case "tenant_not_found":
            switch AppLanguage.language {
            case .ru:
                return "Компания не найдена"
            case .en:
                return "Company not found"
            case .kz:
                return "Компания табылмады"
            }
            
        case "need_enter_tenant_code":
            switch AppLanguage.language {
            case .ru:
                return "Необходимо ввести код компании"
            case .en:
                return "You must enter the company code"
            case .kz:
                return "Сіз компания кодын енгізуіңіз керек"
            }
            
            
        default:
            return "detail: \(detail)"
        }
    }
}
