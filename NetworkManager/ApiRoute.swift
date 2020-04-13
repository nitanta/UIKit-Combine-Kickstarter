import Foundation

enum ApiRoute {
    case albums
}

extension ApiRoute {
    var baseURL: URL { return URL(string: Global.baseUrl)! }
    
    enum ApiMethod: String {
        case get
        case post
        case put
        case delete
        case update
    }
    
    var version: String {
        switch self{
        default:
            return ""
        }
    }
    
    var path: String {
        switch self {
        case .albums:
            return "/public-api/albums"
        }
    }
    
    var method: ApiMethod {
        switch self {
        case .albums:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        default:
            return [:]
        }
    }
    
    var headers: [String: String] {
        switch self {
        default:
            return ["Authorization": "Bearer e1qnQivu9DZIuGDtCaHDX6s7AkJ-oG3P8uN2"
            ]
        }
        
    }
}



private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
