struct UserNew: Encodable {
    let name: String
    let email: String
    let phone: String
    let positionID: Int
    let photo: String

    enum CodingKeys: String, CodingKey {
        case positionID = "position_id"
    }
}
