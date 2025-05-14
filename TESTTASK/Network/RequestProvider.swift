import Alamofire

typealias Parameters = [String: Any]

final class RequestProvider {
    static let shared = RequestProvider()
    private init() {}
    
    private let baseURL = "https://frontend-test-assignment-api.abz.agency/api/v1"
    
    func call<T: Decodable>(endpoint: Endpoint, method: HTTPMethod, parameters: Parameters? = nil, token: String? = nil) async throws -> T {
        let urlPath = fullPath(for: endpoint)
        let request = AF.request(urlPath, method: method, parameters: parameters, headers: header(for: token))
        
        return try await request
            .validate()
            .serializingDecodable(T.self)
            .value
    }
    
    enum Endpoint {
        case token, positions, users
    }
    
    private func fullPath(for endpoint: Endpoint) -> String {
        switch endpoint {
        case .token:
            return baseURL + "/token"
        case .positions:
            return baseURL + "/positions"
        case .users:
            return baseURL + "/users"
        }
    }
    
    private func header(for token: String?) -> HTTPHeaders? {
        guard let token else { return nil }
        return [ "Token": token ]
    }
}
