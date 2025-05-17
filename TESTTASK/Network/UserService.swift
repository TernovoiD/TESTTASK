import Foundation
import Alamofire

final class UserService {
    private let baseURL = "https://frontend-test-assignment-api.abz.agency/api/v1"
    private let usersPerPage = "6"
    
    func load(page: Int) async throws -> [User] {
        let urlPath = fullPath(for: .users)
        let parameters = [ "page": String(page), "count": usersPerPage ]
        let request = AF.request(urlPath, method: .get, parameters: parameters)
        
        let response = try await request
            .validate()
            .serializingDecodable(APIUsersResponse.self)
            .value
        
        let apiUsers = response.users
        guard let apiUsers else { return [ ] }
        return apiUsers.compactMap({ $0.transform() })
    }
    
    func getToken() async throws -> String? {
        let urlPath = fullPath(for: .token)
        let request = AF.request(urlPath, method: .get)
        
        let response = try await request
            .validate()
            .serializingDecodable(APITokneResponse.self)
            .value
        
        return response.token
    }
    
    func loadPositions() async throws -> [Position] {
        let urlPath = fullPath(for: .positions)
        let request = AF.request(urlPath, method: .get)
        
        let response = try await request
            .validate()
            .serializingDecodable(APIPositionsResponse.self)
            .value
        
        
        let apiPositions = response.positions
        guard let apiPositions else { return [ ] }
        return apiPositions.compactMap({ $0.transform() })
    }
    
    func uploadProfile(user: UserNew, token: String) async -> Bool {
        let urlPath = fullPath(for: .users)
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Token": token
        ]
        let response = await AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(Data(user.name.utf8), withName: "name")
                multipartFormData.append(Data(user.email.utf8), withName: "email")
                multipartFormData.append(Data(user.phone.utf8), withName: "phone")
                multipartFormData.append(Data(String(user.positionID).utf8), withName: "position_id")
                multipartFormData.append(user.photo, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpeg")
            }, to: urlPath, headers: headers)
        .validate()
        .serializingData()
        .response
        
        if let _ = response.error { return false } else { return true }
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
}
