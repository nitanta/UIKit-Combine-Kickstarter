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

class APIService<T: Codable>: NSObject {
    
    func request(route :ApiRoute)  -> AnyPublisher<ApiResponse<T>, APIError> {
        let request = NSMutableURLRequest()
        request.httpMethod = route.method.rawValue
        request.url = URL(string: route.baseURL.absoluteString + route.path)!
        route.headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        request.httpBody = (route.parameters ?? [:]).dataRepresentation

        return URLSession.DataTaskPublisher(request: request as URLRequest, session: .shared)
            .tryMap { data, response in
                debugPrint("*******************************************************************")
                debugPrint(response)
                debugPrint( String(decoding: data, as: UTF8.self))
                debugPrint("*******************************************************************")
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unknown
                }
                return data
        }.decode(type: ApiResponse<T>.self, decoder: JSONDecoder())
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
