import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

class APIService: NSObject {
    class var sharedAPIService: APIService {
        struct Singleton {
            static let sharedInstance: APIService = APIService()
        }
        return Singleton.sharedInstance
    }
    
    func request(route :ApiRoute)  -> AnyPublisher<ApiResponse, APIError> {
        let request = NSMutableURLRequest()
        request.httpMethod = route.method.rawValue
        request.url = URL(string: route.baseURL.absoluteString + route.path)!
        route.headers.forEach {
            request.addValue($0.key, forHTTPHeaderField: $0.value)
        }
        request.httpBody = (route.parameters ?? [:]).dataRepresentation
        debugPrint(":::::::::::::::::::::::::::::::::::::::::::::::::::")
        debugPrint(request.httpMethod)
        debugPrint(request.url)
        debugPrint(request.allHTTPHeaderFields)
        debugPrint(request.httpBody)
        debugPrint(":::::::::::::::::::::::::::::::::::::::::::::::::::")

        return URLSession.DataTaskPublisher(request: request as URLRequest, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unknown
                }
                return data
        }.decode(type: ApiResponse.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
        }
        .eraseToAnyPublisher()
    }
}

extension Dictionary {
    var dataRepresentation: Data? {
        guard !self.isEmpty else { return nil }
        guard let theJSONData = try? JSONSerialization.data(withJSONObject: self,
                                                            options: [.prettyPrinted]) else {
            return nil
        }
        return theJSONData
    }
}
