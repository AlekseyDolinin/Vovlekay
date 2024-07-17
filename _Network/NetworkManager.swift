import Foundation

typealias Response_ = (data_: Data?, response_: URLResponse?, error_: Error?)

class NetworkManager {
        
    static let shared = NetworkManager()
    
    func getJSON(link: String, loader: Bool = true, checkError: Bool = true) async -> JSON? {
        let dataResponse: Response_ = await _request(link)
        if dataResponse.error_ != nil { ErrorParser.shared.parse(input: dataResponse) }
        if let data = dataResponse.data_ {
            let json = JSON(data)
            if let _ = json["detail"].string {
                ErrorParser.shared.parse(input: dataResponse)
                return nil
            } else {
                return json
            }
        } else {
            if let httpResponse = dataResponse.response_ as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
            }
            return nil
        }
    }
    
    
    private func _request(_ link: String,
                         method: HTTPMethod = .get,
                         parameters: Any? = nil) async -> Response_ {
        guard let url = URL(string: link.lowercased()) else {
            print("BAD LINK: \(link)")
            return (nil, nil, nil)
        }
        var request = URLRequest(url: url)
        setCookieInRequest(&request)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if parameters != nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted)
            } catch let error {
                print("error_add_parameters: \(error.localizedDescription)")
                return (nil, nil, error)
            }
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return (data, response, nil)
        } catch {
            print("Неожиданная ошибка: \(error).")
            return (nil, nil, error)
        }
    }
    
    public func setCookieInRequest(_ request_: inout URLRequest) {
        // UserDefaults
        guard let savedCookie = UserDefaults.standard.dictionary(forKey: "cookies") else { return }
        guard let dictionary = savedCookie["user_id"] as? Dictionary<String, Any> else { return }
        guard let value: String = dictionary["Value"] as? String else { return }
        guard let name: String = dictionary["Name"] as? String else { return }
        let cookies_header = "\(name)=\(value); " + "language=\(AppLanguage.language.rawValue);"
        request_.setValue(cookies_header, forHTTPHeaderField: "Cookie")
        
//        // keychain
//        let cookie = LocalServices.getCookie()
//        if let name = cookie.name, let value = cookie.value {
//            let cookies_header = "\(name)=\(value); " + "language=\(AppLanguage.language.rawValue);"
//            request_.setValue(cookies_header, forHTTPHeaderField: "Cookie")
//        }
    }
    
    
    public enum HTTPMethod: String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case delete  = "DELETE"
    }
}
