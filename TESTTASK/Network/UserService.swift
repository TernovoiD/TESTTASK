import Foundation

final class UserService {
    private let request = RequestProvider.shared
    private let usersPerPage = "6"
    
    func load(page: Int) async throws -> [User] {
        let parameters = [ "page": String(page), "count": usersPerPage ]
        let response: APIUsersResponse = try await request.call(endpoint: .users, method: .get, parameters: parameters)
        let apiUsers = response.users
        guard let apiUsers else { return [ ] }
        return apiUsers.compactMap({ $0.transform() })
    }
    
    func getToken() async throws -> String? {
        let response: APITokneResponse = try await request.call(endpoint: .token, method: .get)
        return response.token
    }
    
    func loadPositions() async throws -> [Position] {
        let response: APIPositionsResponse = try await request.call(endpoint: .positions, method: .get)
        let apiPositions = response.positions
        guard let apiPositions else { return [ ] }
        return apiPositions.compactMap({ $0.transform() })
    }
    
    func register(_ user: UserNew, with token: String) async throws -> Bool {
        let parameters = parameters(for: user)
        let response: APINewUserResponse = try await request.call(endpoint: .users, method: .get, parameters: parameters)
        guard let success = response.success else { return false }
        return success
    }
    
    private func parameters(for user: UserNew) -> Parameters {
        let parameters: Parameters = [
            "name": user.name,
            "email": user.email,
            "phone": user.phone,
            "position_id": user.positionID,
            "photo": user.photo
        ]
        
        return parameters
    }
}
