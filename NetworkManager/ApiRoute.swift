import Foundation

enum ApiRoute {
    case signIn(email: String, password: String)
    case aboutUs
    case register(email: String, firstName: String, lastName: String, username: String, orgId: String)
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
            return "v2.0/"
        }
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "login"
        case .aboutUs:
            return "about-us"
        case .register:
            return "register"
        }
    }
    
    var method: ApiMethod {
        switch self {
        case .signIn, .register:
            return .post
        default:
            return .get
        }
    }
    var parameters: [String: Any]? {
        switch self {
        case .signIn(let params):
            return ["username" : params.email,
                    "password" : params.password,
                    "device_id" :  "",
                    "device_type": "ios",
                    "device_token": ""
                    ]
        case .register(let params):
            return ["email" : params.email,
                    "firstname" : params.firstName,
                    "lastname" : params.lastName,
                    "username" : params.username,
                    "org-id" : params.orgId,
                    "device_id" :"",
                    "device_type": "ios",
                    "device_token": ""
            ]
        default:
            return [:]
        }
    }
    
    var headers: [String: String] {
        switch self {
        case .register(let param):
            return ["Content-type": "application/json"
            ]
        default:
            return ["Content-type": "application/json",
                    "api-key" : ""
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
